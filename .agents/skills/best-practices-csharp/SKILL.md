---
name: best-practices-csharp
description: Orientar a IA sobre convenções e boas práticas de implementação em C#.
metadata:
  short-description: Define convenções e decisões de implementação em C#.
---

# Boas práticas de programação em C#

## Objetivo

Definir convenções de implementação em C#. O código gerado por IA deve ser idiomático, claro e fácil de manter por pessoas.

## Padrões gerais

- Separe etapas lógicas distintas com uma linha em branco. Não insira linhas em branco entre instruções que formam uma única operação. Exemplo:
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

- Quando o retorno tiver significado próprio ou for usado em vários pontos, prefira um tipo nomeado a uma tupla. Use `sealed record` para representar dados cujo valor é definido pelos componentes; use `sealed class` quando o tipo precisar de identidade própria ou comportamento mutável. Declare o tipo no escopo apropriado ao seu uso.

Exemplo para evitar:
```csharp
private async Task<(Car? Car, Model? Model)> GetInfo(Query query, CancellationToken cancellationToken)
```

Exemplo para seguir:
```csharp
private async Task<CarInfo> GetInfo(Query query, CancellationToken cancellationToken)
```

- Prefira condições positivas que expressem diretamente o caso tratado. Evite negações duplas e nomes de predicados negativos, pois tornam expressões booleanas mais difíceis de ler.

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

As condições dos exemplos devem representar a mesma regra de negócio para que a transformação preserve o comportamento. Por exemplo, `query.EnumType != MyEnum.Canceled` só deve ser reescrita como uma comparação positiva quando o caso desejado estiver definido com precisão; ela não é necessariamente equivalente a `query.EnumType == MyEnum.Done`.
