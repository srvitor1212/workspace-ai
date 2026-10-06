---
name: best-practices-csharp
description: Instruir a IA das melhores práticas de codificalção na linguagem C#.
metadata:
  short-description: Define práticas e decições de como codificar na linguagem.
---

# Melhores práticas de programação

## Objetivo

Definir as boas práricas de codificação.

## Padrões gerais

- Procure colocar uma linha em branco entre cada comando. Exemplo:
```csharp
private async Task<Result<BaseResponse>> Sample(
    Command command,
    CancellationToken cancellationToken)
{
    var routeExternalId = command.Route.Id;

    var masterDataResult = await _getMasterData.GetMasterData(
        CreateMasterDataQuery(command), cancellationToken);

    if (masterDataResult.Value is not null)
        return Result<BaseResponse>.Conflict($"RouteClosed {routeExternalId} already exists");

    return await ExecuteClosedConsumerInSeparateScope(command, cancellationToken);
}
```