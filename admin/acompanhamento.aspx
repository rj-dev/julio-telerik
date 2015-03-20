<%@ Page Title="" Language="C#" MasterPageFile="~/admin/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="acompanhamento.aspx.cs" Inherits="admin_acompanhamento" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2009.3.1208.20, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" AllowSorting="True"
                Skin="WebBlue" OnNeedDataSource="RadGrid1_OnNeedDataSource" OnSelectedIndexChanged="RadGrid1_OnSelectedIndexChanged" AllowFilteringByColumn="True" Width="100%" Height="500"
                CellSpacing="0" GridLines="None">
                <GroupingSettings CaseSensitive="false" />
                <MasterTableView AutoGenerateColumns="false">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Cliente" HeaderText="Cliente" UniqueName="Cliente" CurrentFilterFunction="Contains" AllowFiltering="True" ShowFilterIcon="false" AutoPostBackOnFilter="True" FilterControlWidth="100%" />
                        <telerik:GridBoundColumn DataField="Imobiliaria" HeaderText="Imobiliaria" UniqueName="Imobiliaria" ShowFilterIcon="false" AutoPostBackOnFilter="True" FilterControlWidth="100%" />
                        <telerik:GridBoundColumn DataField="Status" HeaderText="Status" UniqueName="Status" ShowFilterIcon="false" AutoPostBackOnFilter="True" FilterControlWidth="100%" />
                        <telerik:GridBoundColumn DataField="Ultima_Atualizacao" HeaderText="Ultima Atualização" UniqueName="Ultima_Atualizacao" ShowFilterIcon="false" />
                        <telerik:GridTemplateColumn HeaderText="Excluir" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:Button ID="bt_excluir" runat="server" CommandName="Excluir" Text="X" BackColor="Red" OnClientClick="if(confirm('Deseja realmente excluir o cliente?')){return true}else{return false}" />
                                <asp:HiddenField runat="server" ID="hfIdCliente" Value='<%#Eval("ID_Cliente")%>' />
                                <asp:HiddenField runat="server" ID="hfIdProcesso" Value='<%#Eval("ID_Processo")%>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings Selecting-AllowRowSelect="true" EnablePostBackOnRowClick="true">
                </ClientSettings>
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>

    <telerik:RadWindowManager ID="RadWindowManager1" ShowContentDuringLoad="false" VisibleStatusbar="false"
        ReloadOnShow="true" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Skin="Web20" Modal="True" Style="z-index: 7002" Width="990" Height="500" EnableShadow="true">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table width="100%" style="background: url(../images/casa-propria-v3.jpg) no-repeat center center; font-size: 0.9em;">
                                <tr>
                                    <td>
                                        <div id="div_salvar_alteracoes" style="background-color: Green; text-align: center; display: none;">
                                            <h3 style="color: White;">Cadastro alterado com sucesso!</h3>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="tabs">
                                            <ul>
                                                <li><a href="#tabs-dadoscadastrais" onclick="if(document.getElementById('<%=ddl_estado_civil.ClientID%>').value==2){Fecha_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '660');document.getElementById('tab_dados_conjuge').style.display = 'block';}else{Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '600');}">Dados Comprador</a></li>
                                                <li><a href="#tabs-dadosvendedor" onclick="Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '640');">Dados Vendedor</a></li>
                                                <li><a href="#tabs-dadosprofissionais" onclick="Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '660');">Dados Profissionais</a></li>
                                                <li><a href="#tabs-condicoesfinanciamento" onclick="Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '320');">Condições de Financiamento</a></li>
                                                <li><a href="#tabs-dadosimovel" onclick="Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '300');">Dados do Imóvel</a></li>
                                                <li><a href="#tabs-dadosavaliacao" onclick="Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '300');">Dados da Avaliação</a></li>
                                                <li><a href="#tabs-historico" onclick="Fecha_modal_popup('fundo_modal_popup_geral','div_modal_envio_email_solicitacao_servico');Abre_modal_popup('fundo_modal_popup_geral', 'div_modal_envio_email_solicitacao_servico', '1030', '450');">Histórico</a></li>
                                            </ul>
                                            <div id="tabs-dadoscadastrais">
                                                <asp:Panel ID="pnl_dadoscadastrais" runat="server" ScrollBars="Vertical" Height="450">
                                                    <table>
                                                        <tr>
                                                            <td colspan="2">
                                                                <h5>Dados Cliente</h5>
                                                                <asp:HiddenField ID="hf_id_cliente_alteracao" runat="server" />
                                                                <asp:HiddenField ID="hf_id_processo_alteracao" runat="server" />
                                                                <asp:HiddenField ID="hf_id_financiamento_alteracao" runat="server" />
                                                                <hr />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Nome:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_nome_cliente" runat="server" Width="575" MaxLength="200"></asp:TextBox>
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfv_txt_nome_cliente" runat="server" ErrorMessage="Digite o Nome"
                                                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_nome_cliente"
                                                                    ValidationGroup="salvar_alteracoes">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>RG:
                                                            </td>
                                                            <td>
                                                                <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_rg_cliente" runat="server" MaxLength="15"></asp:TextBox>
                                                                        </td>
                                                                        <td>*CPF:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_cpf_cliente" runat="server" MaxLength="15"></asp:TextBox>
                                                                            <br />
                                                                            <asp:RequiredFieldValidator ID="rfv_txt_cpf_cliente" runat="server" ErrorMessage="Digite o CPF"
                                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_cpf_cliente"
                                                                                ValidationGroup="salvar_alteracoes">
                                                                            </asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="rev_" runat="server" ErrorMessage="CPF inválido"
                                                                                Display="Dynamic" ValidationExpression="^\d{3}\.\d{3}\.\d{3}-\d{2}$" ControlToValidate="txt_cpf_cliente"
                                                                                SetFocusOnError="true" ValidationGroup="salvar_alteracoes">
                                                                            </asp:RegularExpressionValidator>
                                                                        </td>
                                                                        <td>Senha:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_senha_cliente" runat="server" MaxLength="15" Width="98"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Endereço:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_endereco_cliente" runat="server" Width="576" MaxLength="500"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Data Nascimento:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_data_nascimento_cliente" runat="server"></asp:TextBox>
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfv_txt_data_nascimento_cliente" runat="server" ErrorMessage="Digite a Data de Nascimento"
                                                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_data_nascimento_cliente"
                                                                    ValidationGroup="salvar_alteracoes">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>E-mail:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_email_cliente" runat="server" Width="576" MaxLength="50"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tel. Fixo:
                                                            </td>
                                                            <td>
                                                                <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_tel_fixo_cliente" runat="server" MaxLength="15"></asp:TextBox>
                                                                        </td>
                                                                        <td>Tel. Comercial
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_tel_comercial_cliente" runat="server" MaxLength="15" Width="110"></asp:TextBox>
                                                                        </td>
                                                                        <td>Tel. Celular:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_tel_celular_cliente" runat="server" MaxLength="15" Width="110"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Imobiliária:
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddl_imobiliaria" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Estado Civil:
                                                            </td>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddl_estado_civil" runat="server">
                                                                                <asp:ListItem Text="Solteiro(a)" Value="1"></asp:ListItem>
                                                                                <asp:ListItem Text="Casado(a)" Value="2"></asp:ListItem>
                                                                                <asp:ListItem Text="Viúvo(a)" Value="3"></asp:ListItem>
                                                                                <asp:ListItem Text="Separado(a)" Value="4"></asp:ListItem>
                                                                                <asp:ListItem Text="Desquitado(a)" Value="5"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>Regime Casamento:
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddl_regime_casamento" runat="server">
                                                                                <asp:ListItem Text="Selecione" Value="0"></asp:ListItem>
                                                                                <asp:ListItem Text="Comunhão parcial de bens" Value="1"></asp:ListItem>
                                                                                <asp:ListItem Text="Comunhão total de bens" Value="2"></asp:ListItem>
                                                                                <asp:ListItem Text="Separação total de bens" Value="3"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Nome Pai:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_nome_pai_cliente" runat="server" Width="575" MaxLength="200"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Nome Mãe:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_nome_mae_cliente" runat="server" Width="575" MaxLength="200"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <table id="tab_dados_conjuge" style="display: none;">
                                                                    <tr>
                                                                        <td colspan="4">
                                                                            <h5>Dados Cônjuge</h5>
                                                                            <hr />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>*Nome Cônjuge:
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:TextBox ID="txt_nome_conjuge_cliente" runat="server" Width="575" MaxLength="200"></asp:TextBox>
                                                                            <div id="div_erro_nome_conjuge" style="font-size: small; color: Red; display: none;">
                                                                                Digite o Nome do Cônjuge
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>RG:
                                                                        </td>
                                                                        <td style="width: 175px;">
                                                                            <asp:TextBox ID="txt_rg_conjuge" runat="server" MaxLength="15"></asp:TextBox>
                                                                        </td>
                                                                        <td style="width: 50px;">*CPF:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_cpf_conjuge" runat="server" MaxLength="15"></asp:TextBox>
                                                                            <div id="div_erro_cpf_conjuge" style="font-size: small; color: Red; display: none;">
                                                                                Digite o CPF do Cônjuge
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Endereço:
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:TextBox ID="txt_endereco_conjuge" runat="server" Width="576" MaxLength="500"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>*Data Nascimento:
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:TextBox ID="txt_data_nascimento_conjuge" runat="server"></asp:TextBox>
                                                                            <div id="div_erro_data_nascimento_conjuge" style="font-size: small; color: Red; display: none;">
                                                                                Digite a Data de Nascimento do Cônjuge
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Nome Pai:
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:TextBox ID="txt_nome_pai_conjuge" runat="server" Width="575" MaxLength="200"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Nome Mãe:
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <asp:TextBox ID="txt_nome_mae_conjuge" runat="server" Width="575" MaxLength="200"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Observações:
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:TextBox ID="txt_obs_cliente" runat="server" TextMode="MultiLine" Width="98%"
                                                                    Height="70" MaxLength="1000"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                            <div id="tabs-dadosvendedor">
                                                <asp:Panel ID="pnl_dadosvendedor" runat="server" ScrollBars="Vertical" Height="460">
                                                    <table>
                                                        <tr>
                                                            <td colspan="3">
                                                                <h5>Dados Vendedor</h5>
                                                                <hr />
                                                                <asp:HiddenField ID="hf_id_vendedor_alteracao" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <div id="div_salvar_alteracoes_vendedor" style="background-color: Green; text-align: center; display: none;">
                                                                    <h3 style="color: White;">Cadastro alterado com sucesso!</h3>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Nome:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_nome_vendedor" runat="server" Width="517" MaxLength="200"></asp:TextBox>
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfv_txt_nome_vendedor" runat="server" ErrorMessage="Digite o Nome"
                                                                    SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_nome_vendedor"
                                                                    ValidationGroup="cadastrar_vendedor">
                                                                </asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <div style="text-align: center">
                                                                    <asp:Label ID="lbl_contagem_lista_vendedores" runat="server" Text="Não há nenhum vendedor na lista"></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>RG:
                                                            </td>
                                                            <td>
                                                                <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_rg_vendedor" runat="server" MaxLength="15" Width="130"></asp:TextBox>
                                                                        </td>
                                                                        <td>*CPF:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_cpf_vendedor" runat="server" MaxLength="15" Width="130"></asp:TextBox>
                                                                            <br />
                                                                            <asp:RequiredFieldValidator ID="rfv_txt_cpf_vendedor" runat="server" ErrorMessage="Digite o CPF"
                                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_cpf_vendedor"
                                                                                ValidationGroup="cadastrar_vendedor">
                                                                            </asp:RequiredFieldValidator>
                                                                            <asp:RegularExpressionValidator ID="rev_txt_cpf_vendedor" runat="server" ErrorMessage="CPF inválido"
                                                                                Display="Dynamic" ValidationExpression="^\d{3}\.\d{3}\.\d{3}-\d{2}$" ControlToValidate="txt_cpf_vendedor"
                                                                                SetFocusOnError="true" ValidationGroup="cadastrar_vendedor">
                                                                            </asp:RegularExpressionValidator>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td rowspan="9" valign="top">
                                                                <asp:Panel ID="pnl_lista_vendedores" runat="server" Height="195" Width="310" ScrollBars="Vertical"
                                                                    Visible="false">
                                                                    <asp:GridView ID="gv_lista_vendedores" runat="server" AutoGenerateColumns="False"
                                                                        BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3"
                                                                        CellSpacing="1" EnableModelValidation="True" GridLines="None" Width="100%" OnRowCommand="gv_lista_vendedores_RowCommand">
                                                                        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                                                                        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                                                                        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                                                                        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                        <Columns>
                                                                            <asp:BoundField DataField="Nome" HeaderText="Vendedor" />
                                                                            <%--<asp:BoundField DataField="RG" HeaderText="R.G." />
                                                                <asp:BoundField DataField="Telefone_Fixo" HeaderText="Telefone" />--%>
                                                                            <asp:TemplateField HeaderText="Opções">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="bt_excluir_vendedor_lista" runat="server" BackColor="#CC0000" OnClientClick="if(confirm('Confirma exclusão do vendedor?')){document.getElementById('ctl00_MainContent_hf_aba_ativa').value = '1';return true;}else{return false;}"
                                                                                        CommandArgument="<%#gv_lista_vendedores.Rows.Count%>" CommandName="Excluir_Vendedor_Lista"
                                                                                        Font-Bold="True" ForeColor="White" Text="X" ToolTip="Excluir" />
                                                                                    <asp:HiddenField ID="hf_id_vendedor_controle" runat="server" Value='<%#Eval("ID")%>' />
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" Width="70px" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Endereço:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_endereco_vendedor" runat="server" Width="517" MaxLength="500"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Data Nascimento:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_data_nascimento_vendedor" runat="server" Width="130"></asp:TextBox>
                                                                <br />
                                                                <asp:RequiredFieldValidator ID="rfv_txt_data_nascimento_vendedor" runat="server"
                                                                    ErrorMessage="Digite a Data de Nascimento" SetFocusOnError="true" Display="Dynamic"
                                                                    ControlToValidate="txt_data_nascimento_vendedor" ValidationGroup="cadastrar_vendedor">
                                                                </asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="rev_txt_data_nascimento_vendedor" runat="server"
                                                                    ErrorMessage="Data de nascimento inválida" Display="Dynamic" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$"
                                                                    ControlToValidate="txt_data_nascimento_vendedor" SetFocusOnError="true" ValidationGroup="cadastrar_vendedor">
                                                                </asp:RegularExpressionValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>E-mail:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_email_vendedor" runat="server" Width="517" MaxLength="50"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tel. Fixo:
                                                            </td>
                                                            <td>
                                                                <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_telefone_fixo_vendedor" runat="server" MaxLength="15" Width="130"></asp:TextBox>
                                                                        </td>
                                                                        <td>Tel. Comercial:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_telefone_comercial_vendedor" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                                        </td>
                                                                        <td>Tel. Celular:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_telefone_celular_vendedor" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>*Estado Civil:
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddl_estado_civil_vendedor" runat="server">
                                                                    <asp:ListItem Text="Solteiro(a)" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="Casado(a)" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="Viúvo(a)" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="Separado(a)" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="Desquitado(a)" Value="5"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Nome Pai:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_nome_pai_vendedor" runat="server" Width="517" MaxLength="200"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Nome Mãe:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_nome_mae_vendedor" runat="server" Width="517" MaxLength="200"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <table id="tab_dados_conjuge_vendedor" style="display: none;">
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <h5>Dados Cônjuge</h5>
                                                                            <hr />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>*Nome Cônjuge:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_nome_conjuge_vendedor" runat="server" Width="517" MaxLength="200"></asp:TextBox>
                                                                            <div id="div_erro_nome_conjuge_vendedor" style="font-size: small; color: Red; display: none;">
                                                                                Digite o Nome do Cônjuge
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>RG:
                                                                        </td>
                                                                        <td>
                                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txt_rg_conjuge_vendedor" runat="server" MaxLength="15" Width="130"></asp:TextBox>
                                                                                    </td>
                                                                                    <td>*CPF:
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txt_cpf_conjuge_vendedor" runat="server" MaxLength="15" Width="130"></asp:TextBox>
                                                                                        <div id="div_erro_cpf_conjuge_vendedor" style="font-size: small; color: Red; display: none;">
                                                                                            Digite o CPF do Cônjuge
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Endereço:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_endereco_conjuge_vendedor" runat="server" Width="517" MaxLength="500"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>*Data Nascimento:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_data_nascimento_conjuge_vendedor" runat="server" Width="130"></asp:TextBox>
                                                                            <div id="div_erro_data_nascimento_conjuge_vendedor" style="font-size: small; color: Red; display: none;">
                                                                                Digite a Data de Nascimento do Cônjuge
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Nome Pai:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_nome_pai_conjuge_vendedor" runat="server" Width="517" MaxLength="200"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Nome Mãe:
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txt_nome_mae_conjuge_vendedor" runat="server" Width="517" MaxLength="200"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Observações:
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:TextBox ID="txt_obs_vendedor" runat="server" TextMode="MultiLine" Width="98%"
                                                                    Height="50" MaxLength="1000"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" align="right">
                                                                <asp:Button ID="bt_incluir_vendedor" runat="server" Text="" ValidationGroup="cadastrar_vendedor" CssClass="bt_incluir_vendedor"
                                                                    OnClick="bt_incluir_vendedor_Click" OnClientClick="document.getElementById('ctl00_MainContent_hf_aba_ativa').value = '1'" />
                                                                <div id="div_alteracao_vendedor" style="display: none;">
                                                                    <asp:Button ID="bt_salvar_alteracoes_vendedor" runat="server" Text=""
                                                                        CssClass="bt_salvar_alteracoes_vendedor"
                                                                        OnClientClick="document.getElementById('ctl00_MainContent_hf_aba_ativa').value = '1';"
                                                                        OnClick="bt_salvar_alteracoes_vendedor_Click" />
                                                                    <input type="button" value="" onclick="Cancela_Alteracao_Vendedor();" class="bt_cancelar" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2"></td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                            <div id="tabs-dadosprofissionais">
                                                <table id="tab_renda_cliente" style="float: left; border-top: 1px solid #ccc; border-left: 1px solid #ccc; border-bottom: 1px solid #ccc;">
                                                    <tr>
                                                        <td colspan="2">
                                                            <h3>Renda Cliente</h3>
                                                            <hr />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda:
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_renda_cliente1" runat="server">
                                                                <asp:ListItem Text="Formal" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Informal" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Profissão:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_profissao_cliente1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Ramo de Atividade:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_ramo_atividade_cliente1" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Empresa:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_empresa_cliente1" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_renda_r_cliente1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Tempo de Serviço:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_tempo_servico1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <br />
                                                            <hr />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda:
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_renda_cliente2" runat="server">
                                                                <asp:ListItem Text="Formal" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Informal" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Profissão:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_profissao_cliente2" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Ramo de Atividade:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_ramo_atividade_cliente2" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Empresa:
                                                        </td>
                                                        <td colspan="4">
                                                            <asp:TextBox ID="txt_empresa_cliente2" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_renda_r_cliente2" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Tempo de Serviço:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_tempo_servico2" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tab_renda_conjuge" style="float: left; border-top: 1px solid #ccc; border-right: 1px solid #ccc; border-bottom: 1px solid #ccc; padding-left: 45px;">
                                                    <tr>
                                                        <td colspan="2">
                                                            <h3>Renda Cônjuge</h3>
                                                            <hr />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda:
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_renda_conjuge1" runat="server">
                                                                <asp:ListItem Text="Formal" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Informal" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Profissão:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_profissao_conjuge1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Ramo de Atividade:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_ramo_atividade_conjuge1" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Empresa:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_empresa_conjuge1" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_renda_r_conjuge1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Tempo de Serviço:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_tempo_servico_conjuge1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <br />
                                                            <hr />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda:
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_renda_conjuge2" runat="server">
                                                                <asp:ListItem Text="Formal" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Informal" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Profissão:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_profissao_conjuge2" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Ramo de Atividade:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_ramo_atividade_conjuge2" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Empresa:
                                                        </td>
                                                        <td colspan="4">
                                                            <asp:TextBox ID="txt_empresa_conjuge2" runat="server" Width="250"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Renda R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_renda_r_conjuge2" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Tempo de Serviço:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_tempo_servico_conjuge2" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td>Observações:
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txt_obs_renda" runat="server" TextMode="MultiLine" Width="850" Height="50"
                                                                MaxLength="1000"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="tabs-condicoesfinanciamento">
                                                <table>
                                                    <tr>
                                                        <td>*Valor Imóvel R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_valor_imovel" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_valor_imovel" runat="server" ErrorMessage="Digite o Valor do Imóvel"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_valor_imovel"
                                                                ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>Observações:
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Entrada R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_entrada_imovel" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_entrada_imovel" runat="server" ErrorMessage="Digite a Entrada"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_entrada_imovel"
                                                                ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                        <td rowspan="8">
                                                            <asp:TextBox ID="txt_obs_financiamento" runat="server" TextMode="MultiLine" Width="200"
                                                                Height="200" MaxLength="1000"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Valor de Financiamento:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_valor_financiamento_imovel" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_valor_financiamento_imovel" runat="server"
                                                                ErrorMessage="Digite o Valor de Financimento" SetFocusOnError="true" Display="Dynamic"
                                                                ControlToValidate="txt_valor_financiamento_imovel" ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*FGTS:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_fgts" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_fgts" runat="server" ErrorMessage="Digite o FGTS"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_fgts" ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Subsídio:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_subsidio" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_subsidio" runat="server" ErrorMessage="Digite o Subsídio"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_subsidio" ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Prazo:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_prazo" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_prazo" runat="server" ErrorMessage="Digite o Prazo"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_prazo" ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Tabela:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_tabela" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_tabela" runat="server" ErrorMessage="Digite a Tabela"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_tabela" ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Modalidade:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_modalidade" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_modalidade" runat="server" ErrorMessage="Digite a Modalidade"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_modalidade" ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="tabs-dadosimovel">
                                                <table>
                                                    <tr>
                                                        <td>Endereço:
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:TextBox ID="txt_endereco_imovel" runat="server" Width="473"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Cidade:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_cidade_imovel" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>Observações:
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Condição:
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddl_condicao_imovel" runat="server">
                                                                <asp:ListItem Text="Novo" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Usado" Value="2"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td rowspan="3">
                                                            <asp:TextBox ID="txt_obs_imovel" runat="server" TextMode="MultiLine" Width="300" Height="78"
                                                                MaxLength="1000"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Matricula:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_matricula" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>IPTU:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_iptu" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="tabs-dadosavaliacao">
                                                <table>
                                                    <tr>
                                                        <td>Data da Solicitação
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_data_solicitacao_avaliacao" runat="server"></asp:TextBox>
                                                            <br />
                                                            <%--<asp:RequiredFieldValidator ID="rfv_txt_data_solicitacao_avaliacao" runat="server"
                                                        ErrorMessage="Digite a Data da Solicitação" SetFocusOnError="true" Display="Dynamic"
                                                        ControlToValidate="txt_data_solicitacao_avaliacao" ValidationGroup="salvar_alteracoes">
                                                    </asp:RequiredFieldValidator>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>*Valor R$:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_valor_avaliacao" runat="server"></asp:TextBox>
                                                            <br />
                                                            <asp:RequiredFieldValidator ID="rfv_txt_valor_avaliacao" runat="server" ErrorMessage="Digite o Valor R$"
                                                                SetFocusOnError="true" Display="Dynamic" ControlToValidate="txt_valor_avaliacao"
                                                                ValidationGroup="salvar_alteracoes">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Data Envio Laudo:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_data_envio_laudo_avaliacao" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">Observações:
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txt_obs_avaliacao" runat="server" TextMode="MultiLine" Width="350" Height="90"
                                                                MaxLength="1000"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="tabs-historico">
                                                <table width="945px">
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td>Evento:
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txt_historico_envento" runat="server" Width="500"></asp:TextBox>
                                                                    </td>
                                                                    <td>Data:
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txt_data_evento" runat="server" Width="110"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="bt_incluir_evento" runat="server" Text="Incluir" OnClick="bt_incluir_evento_Click"
                                                                            OnClientClick="document.getElementById('ctl00_MainContent_hf_aba_ativa').value = '6'" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:CheckBox ID="ckb_informar_cliente" runat="server" Text="Informar Cliente por e-mail" />
                                                                                </td>
                                                                                <td>&nbsp; &nbsp;
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox ID="ckb_informar_imobiliaria" runat="server" Text="Informar Imobiliária por e-mail" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="div_cadastrar_evento" style="background-color: Green; text-align: center; display: none;">
                                                                <h3 style="color: White;">Evento cadastrado com sucesso!</h3>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div id="div_erro_envio_email" style="background-color: Red; text-align: center; display: none;">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Panel ID="pnl_lista_historico" runat="server" Height="300" ScrollBars="Vertical">
                                                                <asp:GridView ID="gv_acompanhamento_processo" runat="server" AutoGenerateColumns="False"
                                                                    Width="100%" CellPadding="4" ForeColor="#333333" GridLines="Vertical" AllowPaging="true"
                                                                    PageSize="10">
                                                                    <AlternatingRowStyle BackColor="White" />
                                                                    <EditRowStyle BackColor="#2461BF" />
                                                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                                    <RowStyle BackColor="#EFF3FB" />
                                                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                                    <Columns>
                                                                        <asp:BoundField HeaderText="Evento" DataField="Evento" />
                                                                        <asp:BoundField HeaderText="Data" DataField="Data_Evento" HeaderStyle-Width="120"
                                                                            ItemStyle-HorizontalAlign="Center" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Button ID="bt_salvar_alteracao" runat="server" Text="" Enabled="true"
                                            OnClick="bt_salvar_alteracao_Click" ValidationGroup="salvar_alteracoes" CssClass="bt_salvar_alteracao" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
</asp:Content>

