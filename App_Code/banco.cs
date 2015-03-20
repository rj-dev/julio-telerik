using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for banco
/// </summary>
public class Banco
{
    /// <summary>
    /// Campo responsável pela definição da string de conexão
    /// </summary>
    private string _strConexao;
    /// <summary>
    /// Campo responsável pelo comando de SQL a ser executado
    /// </summary>
    private MySqlCommand _comandoSQL;
    /// <summary>
    /// Propriedade que expõe o campo para definição do comando de SQL a ser executado
    /// </summary>
    public MySqlCommand ComandoSQL
    {
        get { return _comandoSQL; }
        set { _comandoSQL = value; }
    }
    /// <summary>
    /// Campo que define o objeto de conexão
    /// </summary>
    private MySqlConnection _conn;
    /// <summary>
    /// Campo que define o objeto de transação
    /// </summary>
    private MySqlTransaction _transacao;
    /// <summary>
    /// Construtor que define uma string de conexão fixa e cria os objetos de conexão e
    /// comando
    /// </summary>
    public Banco()
    {
        _strConexao = @"Data Source=mysql.rj.kinghost.net;Initial Catalog=rj;Persist Security Info=True;User ID=rj;Password=rjking";
        _conn = new MySqlConnection(_strConexao);
        _comandoSQL = new MySqlCommand();
        _comandoSQL.Connection = _conn;
    }
    /// <summary>
    /// Construtor que recebe por parametro a string de conexão a ser utilizada e cria
    /// os objetos de comando e conexão
    /// </summary>
    /// <param name="stringConexao">String de conexão a ser utilizada</param>
    public Banco(string stringConexao)
    {
        _strConexao = stringConexao;
        _conn = new MySqlConnection(_strConexao);
        _comandoSQL = new MySqlCommand();
        _comandoSQL.Connection = _conn;
    }
    /// <summary>
    /// Método para abrir a conexão com o banco de dados
    /// </summary>
    /// <param name="transacao">true -> Com transação | false -> Sem transação</param>
    /// <returns></returns>
    public bool AbreConexao(bool transacao)
    {
        try
        {
            _conn.Open();
            if (transacao)
            {
                _transacao = _conn.BeginTransaction();
                _comandoSQL.Transaction = _transacao;
            }
            return true;
        }
        catch
        {
            return false;
        }
    }
    /// <summary>
    /// Métodos para fechar a conexão com o banco de dados
    /// </summary>
    /// <returns>Retorna um booleano para indicar o resultado da operação</returns>
    public bool FechaConexao()
    {
        try
        {
            if (_conn.State == ConnectionState.Open)
                _conn.Close();
            return true;
        }
        catch
        {
            return false;
        }
    }
    /// <summary>
    /// Finaliza uma transação
    /// </summary>
    /// <param name="commit">true -> Executa o commit | false -. Executa o rollback</param>
    public void FinalizaTransacao(bool commit)
    {
        if (commit)
            _transacao.Commit();
        else
            _transacao.Rollback();
        FechaConexao();
    }
    /// <summary>
    /// Destrutor que fecha a conexão com o banco de dados
    /// </summary>
    ~Banco()
    {
        FechaConexao();
    }
    /// <summary>
    /// Método responsável pela execução dos comandos de Insert, Update e Delete
    /// </summary>
    /// <returns>Retorna um número inteiro que indica a quantidade de linhas afetadas</returns>
    public int ExecutaComando(bool transacao)
    {
        int retorno;
        AbreConexao(transacao);
        try
        {
            retorno = _comandoSQL.ExecuteNonQuery();
        }
        catch
        {
            retorno = -1;
        }
        finally
        {
            if (!transacao)
                FechaConexao();
        }
        return retorno;
    }
    /// <summary>
    /// Método responsável pela execução dos comandos de Insert com retorno do último código cadastrado
    /// </summary>
    /// <returns>Retorna um número inteiro que indica a quantidade de linhas afetadas</returns>
    public int ExecutaComando(bool transacao, out int ultimoCodigo)
    {
        int retorno;
        ultimoCodigo = 0;
        AbreConexao(transacao);
        try
        {
            //Executa o comando de insert e já retorna o @@IDENTITY
            ultimoCodigo = Convert.ToInt32(_comandoSQL.ExecuteScalar());
            retorno = 1;
        }
        catch
        {
            retorno = -1;
        }
        finally
        {
            if (!transacao)
                FechaConexao();
        }
        return retorno;
    }
    /// <summary>
    /// Método responsável pela execução dos comandos de Select
    /// </summary>
    /// <returns>Retorna um DataTable com o resultado da operação</returns>
    public DataTable ExecutaSelect()
    {
        AbreConexao(false);
        DataTable dt = new DataTable();
        try
        {
            dt.Load(_comandoSQL.ExecuteReader());
        }
        catch
        {
            dt = null;
        }
        finally
        {
            FechaConexao();
        }
        return dt;
    }
    /// <summary>
    /// Método que executa comandos de Select para retornos escalares, ou seja,
    /// retorna a primeira linha e primeira coluna do resultado do comando de Select.
    /// Para nosso exemplo, sempre convertemos esse valor para Double
    /// </summary>
    /// <returns>Retorna a primeira linha e primeira coluna do resultado comando de Select</returns>
    public double ExecutaScalar()
    {
        AbreConexao(false);
        double retorno;
        try
        {
            retorno = Convert.ToDouble(_comandoSQL.ExecuteScalar());
        }
        catch
        {
            retorno = -1;
        }
        finally
        {
            FechaConexao();
        }
        return retorno;
    }
}