
{component_define_params params=[ 'mods', 'classes', 'attributes' ]}

{* ���������� ������� ���� � ����� *}
{$action = Router::GetAction()}
{$event = Router::GetActionEvent()}

{* ��������� �������� ������� ����� *}
{$templateActionName = "action{$action|ucfirst}"}

{* ��������� �������� ������� ������ *}
{$templateEventName = "event{$event|ucfirst}"}
{$templateEvent = $LS->Component_GetTemplatePath('css-reset', "{$templateActionName}.{$templateEventName}")}

{* ���� ���������� ������ ������, ������� *}
{if $templateEvent}
	{component "css-reset" template="{$templateActionName}.{$templateEventName}" action=$action event=$event params=$params}

{* ����� ������� ������ ����� *}
{else}
	{$templateAction = $LS->Component_GetTemplatePath('css-reset', $templateActionName)}
	{if $templateAction}
		{component "css-reset" template="{$templateActionName}" action=$action params=$params}
	{/if}
{/if}

