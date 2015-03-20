using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class admin_acompanhamento : System.Web.UI.Page
{
    private int idClienteDetalhesProcesso = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //RadWindow1.VisibleOnPageLoad = true;
    }

    protected void RadGrid1_OnNeedDataSource(object source, GridNeedDataSourceEventArgs e)
    {
        HttpCookie autenticacao = new HttpCookie("autenticacao");
        autenticacao["userid"] = "1";
        autenticacao["perfil"] = "3";
        autenticacao["nome"] = "Renato";

        Response.Cookies.Add(autenticacao);

        var db = new Banco();
        db.ComandoSQL.CommandText = "Select * From vwProcessos " + (Request.Cookies["autenticacao"]["perfil"] != "3" ? "WHERE And C.Usuario_Responsavel='" + Request.Cookies["autenticacao"]["userid"] : "");
        RadGrid1.DataSource = db.ExecutaSelect();
    }



    protected void bt_incluir_vendedor_Click(object sender, EventArgs e)
    {
        //using (excelenciaEntities1 ctx = new excelenciaEntities1())
        //{

        //    vendedor VincularVendedor = new vendedor();
        //    VincularVendedor.ID_Cliente = Convert.ToInt32(hf_id_cliente_detalhes.Value);
        //    VincularVendedor.Nome = txt_nome_vendedor.Text;
        //    VincularVendedor.RG = txt_rg_vendedor.Text;
        //    VincularVendedor.CPF = txt_cpf_vendedor.Text;
        //    VincularVendedor.Endereco = txt_endereco_vendedor.Text;
        //    VincularVendedor.Data_Nascimento = Convert.ToDateTime(txt_data_nascimento_vendedor.Text).Date;
        //    VincularVendedor.Email = txt_email_vendedor.Text;
        //    VincularVendedor.Telefone_Fixo = txt_telefone_fixo_vendedor.Text;
        //    VincularVendedor.Estado_Civil = ddl_estado_civil_vendedor.SelectedItem.Text;
        //    VincularVendedor.Nome_Pai = txt_nome_pai_vendedor.Text;
        //    VincularVendedor.Nome_Mae = txt_nome_mae_vendedor.Text;

        //    if (ddl_estado_civil_vendedor.SelectedItem.Text == "Casado(a)")
        //    {
        //        VincularVendedor.Nome_Conjuge = txt_nome_conjuge_vendedor.Text;
        //        VincularVendedor.RG_Conjuge = txt_rg_conjuge_vendedor.Text;
        //        VincularVendedor.CPF_Conjuge = txt_cpf_conjuge_vendedor.Text;
        //        VincularVendedor.Endereco_Conjuge = txt_endereco_conjuge_vendedor.Text;
        //        VincularVendedor.Data_Nascimento_Conjuge = Convert.ToDateTime(txt_data_nascimento_conjuge_vendedor.Text).Date;
        //        VincularVendedor.Nome_Pai_Conjuge = txt_nome_pai_conjuge_vendedor.Text;
        //        VincularVendedor.Nome_Mae_Conjuge = txt_nome_mae_conjuge_vendedor.Text;
        //    }

        //    VincularVendedor.Obs = txt_obs_vendedor.Text;
        //    VincularVendedor.Data_Cadastro = DateTime.Now;
        //    VincularVendedor.Usuario_Cadastro = Convert.ToInt32(Request.Cookies["autenticacao"]["userid"]);
        //    ctx.vendedor.Add(VincularVendedor);
        //    ctx.SaveChanges();
        //}

        ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptConfirmacaoInclusaoVendedorLista", "alert('Vendedor incluído na lista!')", true);
    }

    protected void RadGrid1_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        HiddenField hfIdCliente = (HiddenField)RadGrid1.SelectedItems[0].FindControl("hfIdCliente");//get selected row
        HiddenField hfIdProcesso = (HiddenField)RadGrid1.SelectedItems[0].FindControl("hfIdProcesso");//get selected row

        int vID_Cliente = Convert.ToInt32(hfIdCliente.Value);
        int vID_Processo = Convert.ToInt32(hfIdProcesso.Value);

        idClienteDetalhesProcesso = vID_Cliente;

        Carrega_Detalhes_Processo(vID_Cliente, vID_Processo);

        Carrega_Lista_Vendedores_Vinculados();

        RadWindow1.VisibleOnPageLoad = true;
        RadWindow1.Visible = true;
        string script = "function f(){$find(\"ContentPlaceHolder1_RadWindow1\").show(); Sys.Application.remove_load(f);}Sys.Application.add_load(f);";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "key", script, true);
    }

    protected void gv_lista_vendedores_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        HiddenField hf_ID_DB = (HiddenField)gv_lista_vendedores.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hf_id_vendedor_controle");
        int vID = Convert.ToInt32(hf_ID_DB.Value);

        if (e.CommandName == "Excluir_Vendedor_Lista")
        {
            //vFuncoes.Deleta_Vendedor_Lista(vID);

            Carrega_Lista_Vendedores_Vinculados();
        }
    }

    protected void bt_salvar_alteracoes_vendedor_Click(object sender, EventArgs e)
    {
        int vID_Vendedor = Convert.ToInt32(hf_id_vendedor_alteracao.Value);

        using (var ctx = new excelenciaEntities())
        {
            vendedor v = ctx.vendedor.First(i => i.ID == vID_Vendedor);
            v.Nome = txt_nome_vendedor.Text;
            v.RG = txt_rg_vendedor.Text;
            v.CPF = txt_cpf_vendedor.Text;
            v.Endereco = txt_endereco_vendedor.Text;
            v.Data_Nascimento = Convert.ToDateTime(txt_data_nascimento_vendedor.Text).Date;
            v.Email = txt_email_vendedor.Text;
            v.Telefone_Fixo = txt_telefone_fixo_vendedor.Text;
            v.Telefone_Comercial = txt_telefone_comercial_vendedor.Text;
            v.Telefone_Celular = txt_telefone_celular_vendedor.Text;
            v.Estado_Civil = ddl_estado_civil_vendedor.SelectedItem.Text;
            v.Nome_Pai = txt_nome_pai_vendedor.Text;
            v.Nome_Mae = txt_nome_mae_vendedor.Text;
            v.Obs = txt_obs_vendedor.Text;

            if (ddl_estado_civil_vendedor.SelectedValue == "2")
            {
                v.Nome_Conjuge = txt_nome_conjuge_vendedor.Text;
                v.RG_Conjuge = txt_rg_conjuge_vendedor.Text;
                v.CPF_Conjuge = txt_cpf_conjuge.Text;
                v.Endereco = txt_endereco_vendedor.Text;
                v.Data_Nascimento_Conjuge = Convert.ToDateTime(txt_data_nascimento_conjuge_vendedor.Text).Date;
                v.Nome_Pai_Conjuge = txt_nome_pai_conjuge_vendedor.Text;
                v.Nome_Mae_Conjuge = txt_nome_mae_conjuge_vendedor.Text;
            }

            ctx.SaveChanges();
        }

        Carrega_Lista_Vendedores_Vinculados();

        txt_nome_vendedor.Text = "";
        txt_rg_vendedor.Text = "";
        txt_cpf_vendedor.Text = "";
        txt_endereco_vendedor.Text = "";
        txt_data_nascimento_vendedor.Text = "";
        txt_email_vendedor.Text = "";
        txt_telefone_fixo_vendedor.Text = "";
        txt_telefone_comercial_vendedor.Text = "";
        txt_telefone_celular_vendedor.Text = "";
        txt_nome_pai_vendedor.Text = "";
        txt_nome_mae_vendedor.Text = "";
        txt_nome_conjuge_vendedor.Text = "";
        txt_rg_conjuge_vendedor.Text = "";
        txt_cpf_conjuge.Text = "";
        txt_endereco_vendedor.Text = "";
        txt_data_nascimento_conjuge_vendedor.Text = "";
        txt_nome_pai_conjuge_vendedor.Text = "";
        txt_nome_mae_conjuge_vendedor.Text = "";

        ScriptManager.RegisterStartupScript(this, typeof(Page), "Script_Confirmacao_Alteracao_Vendedor",
                                                   "document.getElementById('div_salvar_alteracoes_vendedor').style.display = 'block';" +
                                                   "setTimeout(\"document.getElementById('div_salvar_alteracoes_vendedor').style.display = 'none'\",4000)", true);



    }

    protected void bt_incluir_evento_Click(object sender, EventArgs e)
    {
        int vID_Cliente = 0;//Convert.ToInt32(hf_id_cliente_detalhes.Value);
        int vID_Processo = 0;//Convert.ToInt32(hf_id_processo_detalhes.Value);

        using (var ctx = new excelenciaEntities())
        {
            historico_processo NovoEvento = new historico_processo();
            NovoEvento.ID_Processo = vID_Processo;
            NovoEvento.ID_Cliente = vID_Cliente;
            NovoEvento.Evento = txt_historico_envento.Text;
            NovoEvento.Data_Evento = Convert.ToDateTime(txt_data_evento.Text + " " + DateTime.Now.TimeOfDay.ToString());
            NovoEvento.Usuario_Responsavel = Convert.ToInt32(Request.Cookies["autenticacao"]["userid"]);
            ctx.historico_processo.Add(NovoEvento);
            ctx.SaveChanges();
        }

        Carrega_Historico_Processo(vID_Cliente, vID_Processo);

        txt_historico_envento.Text = "";

        ScriptManager.RegisterStartupScript(this, typeof(Page), "Script_Confirmacao_Cadastro_Evento",
                                                   "document.getElementById('div_cadastrar_evento').style.display = 'block';" +
                                                   "setTimeout(\"document.getElementById('div_cadastrar_evento').style.display = 'none'\",5000)", true);

        int vTem_Email_Cliente = 0;// 0 = não tem | 1 = tem
        int vTem_Email_Imobiliaria = 0;// 0 = não tem | 1 = tem

        int vHora = Convert.ToInt32(DateTime.Now.ToString("HH"));
        string vPeriodo = "";

        if (vHora >= 0 && vHora <= 12)
        {
            vPeriodo = "bom dia ";
        }
        else if (vHora >= 13 && vHora <= 17)
        {
            vPeriodo = "boa tarde ";
        }
        else if (vHora >= 18 && vHora <= 23)
        {
            vPeriodo = "boa noite ";
        }

        string vEmail_Cliente = "";
        string vNome_Cliente = "";

        if (ckb_informar_cliente.Checked)
        {
            using (var ctx = new excelenciaEntities())
            {
                var pesquisa_email_cliente = from c in ctx.cadastro where c.ID == vID_Cliente select new { c.Nome, c.Email };

                foreach (var resultado in pesquisa_email_cliente)
                {
                    vNome_Cliente = resultado.Nome;
                    vEmail_Cliente = resultado.Email;

                    if (resultado.Email != "" && resultado.Email != null)
                    {
                        string vMod_Email = Server.MapPath("../mod_email/email_info_atualizacao.htm");
                        if (File.Exists(vMod_Email))
                        {

                            //string vCorpo_Email = vFuncoes.Arquivo_Ler(vMod_Email).ToString();
                            //vCorpo_Email = vCorpo_Email.Replace("<titulo>", "Atualização no processo");
                            //vCorpo_Email = vCorpo_Email.Replace("<topo>", "<a href=\"" + vFuncoes.URL_Sistema() + "\"><img src=\"" + vFuncoes.URL_Sistema() + "/Images/topo_email.gif\" border=\"0\" /></a>");
                            //vCorpo_Email = vCorpo_Email.Replace("<nome>", vNome_Cliente);
                            //vCorpo_Email = vCorpo_Email.Replace("<periodo>", vPeriodo);

                            //vFuncoes.Enviar_Email(vFuncoes.Email_Sistema(), "ExcAssessoria", vEmail_Cliente, "Atualização no processo de financiamento imobiliário - www.excassessoria.com.br", vCorpo_Email);
                        }

                        vTem_Email_Cliente = 1;
                    }


                }
            }
        }

        if (ckb_informar_imobiliaria.Checked)
        {
            string vEmail_Imobiliaria = "";
            string vContato_Imobiliaria = "";
            int vID_Imobiliaria = Convert.ToInt32(ddl_imobiliaria.SelectedValue);

            //using (var ctx = new excelenciaEntities())
            //{
            //    var pesquisa_email_imobiliaria = from tel_imob in ctx.telefones_imobiliaria
            //                                     where tel_imob.ID_Imobiliaria == vID_Imobiliaria
            //                                     select tel_imob;

            //    foreach (var resultado in pesquisa_email_imobiliaria)
            //    {
            //        vEmail_Imobiliaria = resultado.Email;
            //        vContato_Imobiliaria = resultado.Contato;

            //        if (resultado.Email != "" && resultado.Email != null)
            //        {
            //            string vMod_Email = Server.MapPath("../mod_email/email_info_atualizacao.htm");
            //            if (File.Exists(vMod_Email))
            //            {

            //                string vCorpo_Email = vFuncoes.Arquivo_Ler(vMod_Email).ToString();
            //                vCorpo_Email = vCorpo_Email.Replace("<titulo>", "Atualização no processo");
            //                vCorpo_Email = vCorpo_Email.Replace("<topo>", "<a href=\"" + vFuncoes.URL_Sistema() + "\"><img src=\"" + vFuncoes.URL_Sistema() + "/Images/topo_email.gif\" border=\"0\" /></a>");
            //                vCorpo_Email = vCorpo_Email.Replace("<nome>", vNome_Cliente);
            //                vCorpo_Email = vCorpo_Email.Replace("<periodo>", vPeriodo);

            //                vFuncoes.Enviar_Email(vFuncoes.Email_Sistema(), "ExcAssessoria", vEmail_Imobiliaria, "Atualização no processo de financiamento imobiliário - www.excassessoria.com.br", vCorpo_Email);
            //            }

            //            vTem_Email_Imobiliaria = 1;
            //        }
            //    }
            //}
        }

        if (ckb_informar_cliente.Checked && !ckb_informar_imobiliaria.Checked)
        {
            if (vTem_Email_Cliente == 0)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptClienteNaoTemEmailCadastrado",
                    "document.getElementById('div_erro_envio_email').style.display = 'block';" +
                    "document.getElementById('div_erro_envio_email').innerHTML='<h3 style=\"color: White;\">Não foi possivel enviar e-mail para o cliente pois, não há e-mail cadastrado!</h3>';" +
                    "setTimeout(\"document.getElementById('div_erro_envio_email').style.display = 'none'\",8000)", true);
            }
        }
        else if (!ckb_informar_cliente.Checked && ckb_informar_imobiliaria.Checked)
        {
            if (vTem_Email_Imobiliaria == 0)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptImobiliariaNaoTemEmailCadastrado",
                    "document.getElementById('div_erro_envio_email').style.display = 'block';" +
                    "document.getElementById('div_erro_envio_email').innerHTML='<h3 style=\"color: White;\">Não foi possivel enviar e-mail para a imobiliária pois, não há e-mail cadastrado!</h3>';" +
                    "setTimeout(\"document.getElementById('div_erro_envio_email').style.display = 'none'\",8000)", true);
            }
        }
        else if (ckb_informar_cliente.Checked && ckb_informar_imobiliaria.Checked)
        {
            if (vTem_Email_Cliente == 0 && vTem_Email_Imobiliaria == 1)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptClienteNaoTemEmailCadastrado",
                   "document.getElementById('div_erro_envio_email').style.display = 'block';" +
                   "document.getElementById('div_erro_envio_email').innerHTML='<h3 style=\"color: White;\">Não foi possivel enviar e-mail para o cliente pois, não há e-mail cadastrado!</h3>';" +
                   "setTimeout(\"document.getElementById('div_erro_envio_email').style.display = 'none'\",8000)", true);
            }
            else if (vTem_Email_Cliente == 1 && vTem_Email_Imobiliaria == 0)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptImobiliariaNaoTemEmailCadastrado",
                   "document.getElementById('div_erro_envio_email').style.display = 'block';" +
                   "document.getElementById('div_erro_envio_email').innerHTML='<h3 style=\"color: White;\">Não foi possivel enviar e-mail para a imobiliária pois, não há e-mail cadastrado!</h3>';" +
                   "setTimeout(\"document.getElementById('div_erro_envio_email').style.display = 'none'\",8000)", true);
            }
            else if (vTem_Email_Cliente == 0 && vTem_Email_Imobiliaria == 0)
            {
                ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptImobiliariaClienteNaoTemEmailCadastrado",
                   "document.getElementById('div_erro_envio_email').style.display = 'block';" +
                   "document.getElementById('div_erro_envio_email').innerHTML='<h3 style=\"color: White;\">Não foi possivel enviar e-mail pois, o cliente e a imobiliária não tem e-mail cadastrado!</h3>';" +
                   "setTimeout(\"document.getElementById('div_erro_envio_email').style.display = 'none'\",8000)", true);
            }
        }

        ckb_informar_cliente.Checked = false;
        ckb_informar_imobiliaria.Checked = false;

        //Carrega_Processos();
    }

    protected void bt_salvar_alteracao_Click(object sender, EventArgs e)
    {
        int vID_Cliente = 0;// Convert.ToInt32(hf_id_cliente_detalhes.Value);
        int vID_Processo = 0;// Convert.ToInt32(hf_id_processo_detalhes.Value);
        int vID_Financiamento = Convert.ToInt32(hf_id_financiamento_alteracao.Value);

        using (var ctx = new excelenciaEntities())
        {
            cadastro c = ctx.cadastro.First(i => i.ID == vID_Cliente);
            c.Nome = txt_nome_cliente.Text;
            c.RG = txt_rg_cliente.Text;
            c.CPF = txt_cpf_cliente.Text;
            c.Senha = txt_senha_cliente.Text;
            c.Email = txt_email_cliente.Text;
            c.Telefone_Fixo = txt_tel_fixo_cliente.Text;
            c.Telefone_Comercial = txt_tel_comercial_cliente.Text;
            c.Telefone_Celular = txt_tel_celular_cliente.Text;
            c.Endereco = txt_endereco_cliente.Text;
            c.Data_Nascimento = Convert.ToDateTime(txt_data_nascimento_cliente.Text).Date;
            c.Imobiliaria = Convert.ToInt32(ddl_imobiliaria.SelectedValue);
            c.Estado_Civil = ddl_estado_civil.SelectedItem.Text;
            c.Regime_Casamento = Convert.ToInt32(ddl_regime_casamento.SelectedValue);
            c.Nome_Pai = txt_nome_pai_cliente.Text;
            c.Nome_Mae = txt_nome_mae_cliente.Text;

            if (ddl_estado_civil.SelectedItem.Text == "Casado(a)")
            {
                c.Nome_Conjuge = txt_nome_conjuge_cliente.Text;
                c.RG_Conjuge = txt_rg_conjuge.Text;
                c.CPF_Conjuge = txt_cpf_conjuge.Text;
                c.Endereco_Conjuge = txt_endereco_conjuge.Text;
                c.Data_Nascimento_Conjuge = Convert.ToDateTime(txt_data_nascimento_conjuge.Text).Date;
                c.Nome_Pai_Conjuge = txt_nome_pai_conjuge.Text;
                c.Nome_Mae_Conjuge = txt_nome_mae_conjuge.Text;
            }

            c.Email = txt_email_cliente.Text;
            c.Obs_Renda = txt_obs_renda.Text;
            c.Obs_Cliente = txt_obs_cliente.Text;
            c.Data_Alteracao = DateTime.Now;
            c.Usuario_Alteracao = Convert.ToInt32(Request.Cookies["autenticacao"]["userid"]);

            ctx.SaveChanges();

            financiamento f = ctx.financiamento.First(i => i.ID == vID_Financiamento);
            f.Valor_Imovel = Convert.ToDecimal(txt_valor_imovel.Text);
            f.Entrada = Convert.ToDecimal(txt_entrada_imovel.Text);
            f.Valor_Financiamento = Convert.ToDecimal(txt_valor_financiamento_imovel.Text);
            f.FGTS = txt_fgts.Text;
            f.Subsidio = txt_subsidio.Text;
            f.Prazo = txt_prazo.Text;
            f.Tabela = txt_tabela.Text;
            f.Modalidade = txt_modalidade.Text;
            f.Endereco = txt_endereco_imovel.Text;
            f.Cidade = txt_cidade_imovel.Text;
            f.Condicao = Convert.ToInt16(ddl_condicao_imovel.SelectedValue);
            f.Matricula = txt_matricula.Text;
            f.IPTU = txt_iptu.Text;
            f.Obs_Financiamento = txt_obs_financiamento.Text;
            f.Obs_Imovel = txt_obs_imovel.Text;

            ctx.SaveChanges();

            var vID_Financimento = (from finan in ctx.financiamento where finan.ID_Cliente == vID_Cliente select finan.ID).FirstOrDefault();

            avaliacao av = ctx.avaliacao.First(i => i.ID_Financiamento == vID_Financimento);
            if (txt_data_solicitacao_avaliacao.Text != "")
            {
                av.Data_Solicitacao = Convert.ToDateTime(txt_data_solicitacao_avaliacao.Text);
            }

            if (txt_valor_avaliacao.Text != "")
            {
                av.Valor = Convert.ToDecimal(txt_valor_avaliacao.Text);
            }

            if (txt_data_envio_laudo_avaliacao.Text != "")
            {
                av.Data_Envio_Laudo = Convert.ToDateTime(txt_data_envio_laudo_avaliacao.Text);
            }

            av.Obs = txt_obs_avaliacao.Text;

            ctx.SaveChanges();

            ScriptManager.RegisterStartupScript(this, typeof(Page), "Script_Confirmacao_Cadastro_Cliente",
                                                   "document.getElementById('bt_fechar_modal').click();" +
                                                   "document.getElementById('div_salvar_alteracoes').style.display = 'block';" +
                                                   "setTimeout(\"document.getElementById('div_salvar_alteracoes').style.display = 'none';\",6000)", true);
        }

        Carrega_Detalhes_Processo(vID_Cliente, vID_Processo);
    }

    private void Carrega_Detalhes_Processo(int vID_Cliente, int vID_Processo)
    {
        using (var ctx = new excelenciaEntities())
        {
            var pesquisa = from c in ctx.cadastro
                           from f in ctx.financiamento
                           from av in ctx.avaliacao
                           from p in ctx.processos
                           where p.ID_Cliente == vID_Cliente && p.ID == vID_Processo
                           && p.ID_Cliente == c.ID && f.ID_Cliente == c.ID && av.ID_Financiamento == f.ID
                           select new
                           {
                               ID_Cliente = c.ID,
                               c.Nome,
                               c.RG,
                               c.CPF,
                               c.Senha,
                               c.Endereco,
                               c.Data_Nascimento,
                               c.Imobiliaria,
                               c.Estado_Civil,
                               c.Regime_Casamento,
                               c.Nome_Pai,
                               c.Nome_Mae,
                               c.Nome_Conjuge,
                               c.RG_Conjuge,
                               c.CPF_Conjuge,
                               c.Endereco_Conjuge,
                               c.Data_Nascimento_Conjuge,
                               c.Nome_Pai_Conjuge,
                               c.Nome_Mae_Conjuge,
                               c.Obs_Renda,
                               f.Valor_Imovel,
                               f.Entrada,
                               f.Valor_Financiamento,
                               f.FGTS,
                               f.Subsidio,
                               f.Prazo,
                               f.Tabela,
                               f.Modalidade,
                               Endereco_Imovel = f.Endereco,
                               f.Cidade,
                               f.Condicao,
                               f.Matricula,
                               f.IPTU,
                               ID_Financiamento = f.ID,
                               av.Data_Solicitacao,
                               av.Valor,
                               av.Data_Envio_Laudo
                           };

            foreach (var resultado in pesquisa)
            {
                txt_nome_cliente.Text = resultado.Nome;
                txt_rg_cliente.Text = resultado.RG;
                txt_cpf_cliente.Text = resultado.CPF;
                txt_senha_cliente.Text = resultado.Senha;
                txt_endereco_cliente.Text = resultado.Endereco;
                txt_data_nascimento_cliente.Text = String.Format("{0:d}", resultado.Data_Nascimento);
                //ddl_imobiliaria.SelectedValue = resultado.Imobiliaria.ToString();
                ddl_estado_civil.SelectedValue = resultado.Estado_Civil == "Solteiro(a)" ? "1" : resultado.Estado_Civil == "Casado(a)" ? "2" : "3";
                ddl_regime_casamento.SelectedValue = resultado.Regime_Casamento.ToString();
                txt_nome_pai_cliente.Text = resultado.Nome_Pai;
                txt_nome_mae_cliente.Text = resultado.Nome_Mae;
                txt_nome_conjuge_cliente.Text = resultado.Nome_Conjuge;
                txt_rg_conjuge.Text = resultado.RG_Conjuge;
                txt_cpf_conjuge.Text = resultado.CPF_Conjuge;
                txt_endereco_conjuge.Text = resultado.Endereco_Conjuge;
                txt_data_nascimento_conjuge.Text = String.Format("{0:d}", resultado.Data_Nascimento_Conjuge);
                txt_nome_pai_conjuge.Text = resultado.Nome_Pai_Conjuge;
                txt_nome_mae_conjuge.Text = resultado.Nome_Mae_Conjuge;
                txt_obs_renda.Text = resultado.Obs_Renda;
                txt_valor_imovel.Text = String.Format("{0:n}", resultado.Valor_Imovel);
                txt_entrada_imovel.Text = String.Format("{0:n}", resultado.Entrada);
                txt_valor_financiamento_imovel.Text = String.Format("{0:n}", resultado.Valor_Financiamento);
                txt_fgts.Text = resultado.FGTS;
                txt_subsidio.Text = resultado.Subsidio;
                txt_prazo.Text = resultado.Prazo;
                txt_tabela.Text = resultado.Tabela;
                txt_modalidade.Text = resultado.Modalidade;
                txt_endereco_imovel.Text = resultado.Endereco_Imovel;
                txt_cidade_imovel.Text = resultado.Cidade;
                ddl_condicao_imovel.SelectedValue = resultado.Condicao.ToString();
                txt_matricula.Text = resultado.Matricula;
                txt_iptu.Text = resultado.IPTU;
                txt_data_solicitacao_avaliacao.Text = String.Format("{0:d}", resultado.Data_Solicitacao);
                txt_valor_avaliacao.Text = String.Format("{0:n}", resultado.Valor);
                txt_data_envio_laudo_avaliacao.Text = String.Format("{0:d}", resultado.Data_Envio_Laudo);
                hf_id_financiamento_alteracao.Value = resultado.ID_Financiamento.ToString();
                hf_id_cliente_alteracao.Value = resultado.ID_Cliente.ToString();
            }

            var pesquisa_renda = from r in ctx.renda where r.ID_Cliente == vID_Cliente select r;

            foreach (var resultado in pesquisa_renda)
            {
                if (resultado.Controle == 1)
                {
                    ddl_renda_cliente1.SelectedValue = resultado.Tipo_Renda.ToString();
                    txt_profissao_cliente1.Text = resultado.Profissao;
                    txt_ramo_atividade_cliente1.Text = resultado.Ramo_Atividade;
                    txt_empresa_cliente1.Text = resultado.Empresa;
                    txt_renda_r_cliente1.Text = String.Format("{0:n}", resultado.Renda1);
                    txt_tempo_servico1.Text = resultado.Tempo_Servico;

                }

                if (resultado.Controle == 2)
                {
                    ddl_renda_cliente2.SelectedValue = resultado.Tipo_Renda.ToString();
                    txt_profissao_cliente2.Text = resultado.Profissao;
                    txt_ramo_atividade_cliente2.Text = resultado.Ramo_Atividade;
                    txt_empresa_cliente2.Text = resultado.Empresa;
                    txt_renda_r_cliente2.Text = String.Format("{0:n}", resultado.Renda1);
                    txt_tempo_servico2.Text = resultado.Tempo_Servico;
                }

                if (resultado.Controle == 3)
                {
                    ddl_renda_conjuge1.SelectedValue = resultado.Tipo_Renda.ToString();
                    txt_profissao_conjuge1.Text = resultado.Profissao;
                    txt_ramo_atividade_conjuge1.Text = resultado.Ramo_Atividade;
                    txt_empresa_conjuge1.Text = resultado.Empresa;
                    txt_renda_r_conjuge1.Text = String.Format("{0:n}", resultado.Renda1);
                    txt_tempo_servico_conjuge1.Text = resultado.Tempo_Servico;
                }

                if (resultado.Controle == 4)
                {
                    ddl_renda_conjuge2.SelectedValue = resultado.Tipo_Renda.ToString();
                    txt_profissao_conjuge2.Text = resultado.Profissao;
                    txt_ramo_atividade_conjuge2.Text = resultado.Ramo_Atividade;
                    txt_empresa_conjuge2.Text = resultado.Empresa;
                    txt_renda_r_conjuge2.Text = String.Format("{0:n}", resultado.Renda1);
                    txt_tempo_servico_conjuge2.Text = resultado.Tempo_Servico;
                }
            }
        }

        Carrega_Historico_Processo(vID_Cliente, vID_Processo);

        if (ddl_estado_civil.SelectedItem.Text == "Casado(a)")
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptMostraDadosConjuge",
                "document.getElementById('tab_renda_conjuge').style.display = 'block';" +
                "document.getElementById('tab_dados_conjuge').style.display = 'block';", true);


        }
        else
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "ScriptOcultaDadosConjuge",
                "document.getElementById('tab_renda_conjuge').style.display = 'none';" +
                "document.getElementById('tab_renda_cliente').style.borderRight = '1px solid #ccc';", true);

        }



    }

    private void Carrega_Lista_Vendedores_Vinculados()
    {
        int vID_Cliente = idClienteDetalhesProcesso;

        using (var ctx = new excelenciaEntities())
        {
            var pesquisa = from v in ctx.vendedor where v.ID_Cliente == vID_Cliente select v;

            gv_lista_vendedores.DataSource = pesquisa.ToArray();
            gv_lista_vendedores.DataBind();
        }

        if (gv_lista_vendedores.Rows.Count > 0)
        {
            lbl_contagem_lista_vendedores.Text = gv_lista_vendedores.Rows.Count + " registro(s)";
            pnl_lista_vendedores.Visible = true;

            int vID_Linha_DB = 0;

            using (var ctx = new excelenciaEntities())
            {

                for (int i = 0; i < gv_lista_vendedores.Rows.Count; i++)
                {
                    HiddenField vID = (HiddenField)gv_lista_vendedores.Rows[i].Cells[0].FindControl("hf_id_vendedor_controle");
                    vID_Linha_DB = Convert.ToInt32(vID.Value);

                    var pesquisa = ctx.vendedor.First(v => v.ID == vID_Linha_DB);

                    gv_lista_vendedores.Rows[i].Attributes.Add("onmouseover", "this.style.cursor=\"pointer\";");
                    gv_lista_vendedores.Rows[i].Attributes.Add("onclick", "document.getElementById('" + bt_incluir_vendedor.ClientID + "').style.display = 'none';" +
                                                                          "Alterar_Dados_Vendedor('" + pesquisa.ID + "','" + pesquisa.Nome + "','" + pesquisa.RG + "'," +
                                                                          "'" + pesquisa.CPF + "','" + pesquisa.Endereco + "','" + String.Format("{0:d}", pesquisa.Data_Nascimento) + "'," +
                                                                          "'" + pesquisa.Email + "','" + pesquisa.Telefone_Fixo + "','" + pesquisa.Telefone_Comercial + "'," +
                                                                          "'" + pesquisa.Telefone_Celular + "','" + pesquisa.Estado_Civil + "','" + pesquisa.Nome_Pai + "'," +
                                                                          "'" + pesquisa.Nome_Mae + "','" + pesquisa.Nome_Conjuge + "','" + pesquisa.RG_Conjuge + "','" + pesquisa.CPF_Conjuge + "'," +
                                                                          "'" + pesquisa.Endereco_Conjuge + "','" + String.Format("{0:d}", pesquisa.Data_Nascimento_Conjuge) + "'," +
                                                                          "'" + pesquisa.Nome_Pai_Conjuge + "','" + pesquisa.Nome_Mae_Conjuge + "','" + pesquisa.Obs + "');");
                }
            }
        }
        else
        {
            lbl_contagem_lista_vendedores.Text = "Não há nenhum vendedor na lista";
            pnl_lista_vendedores.Visible = false;
        }
    }

    private void Carrega_Historico_Processo(int ID_Cliente, int ID_Processo)
    {
        using (var ctx = new excelenciaEntities())
        {
            var pesquisa = from historico in ctx.historico_processo
                           where historico.ID_Cliente == ID_Cliente && historico.ID_Processo == ID_Processo
                           orderby historico.Data_Evento descending
                           select historico;

            gv_acompanhamento_processo.DataSource = pesquisa.ToArray();
            //gv_acompanhamento_processo.DataBind();
        }
    }

    private void Carrega_Imobiliarias()
    {
        ddl_imobiliaria.Items.Clear();

        using (var ctx = new excelenciaEntities())
        {
            var imobiliarias = from c in ctx.imobiliaria orderby c.Nome select c;

            foreach (var resultado in imobiliarias)
            {
                ddl_imobiliaria.Items.Add(new ListItem(resultado.Nome, resultado.ID.ToString()));
            }
        }

    }
}