---
name: best-practices-csharp
description: Instruir a IA das melhores práticas de codificalção na linguagem C#.
metadata:
  short-description: Define práticas e decições de como codificar na linguagem.
---

# Melhores práticas de programação

## Objetivo

Definir as boas práticas de codificação. O código é gerado por IA mas deve ser de fácil compreensão para humanos.

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

- Prefira usar "sealed record", "sealed class" internas ao invés de tuplas.

Exemplo para evitar:
```csharp
private async Task<(Car? Car, Model? Model)> GetInfo(Query query, CancellationToken cancellationToken)
```

Exemplo para seguir:
```csharp
private async Task<CarInfo> GetInfo(Query query, CancellationToken cancellationToken)
```

- Em IF procure usar a condiçao "se verdadeiro".

Exemplo para evitar:
```csharp
if (query.EnumType != MyEnum.Canceled) { }
if (!IsNotValidType(query)) { }
```

Exemplo para seguir:
```csharp
if (query.EnumType == MyEnum.Done) { }
if (IsValidType(query)) { }
```