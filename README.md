# api-tools

A set of tools helpful in interacting with the Manetu Control Plane

## Getting started

### Prerequisites

- Install [babashka](https://github.com/babashka/babashka#installation)

### Install api-tools into your path

``` bash
make install
```

### Set an authorization token in MANETU_TOKEN

``` bash
export MANETU_TOKEN=<your token here>
```

## Usage

### manetu-graphql-cli

``` bash
$ manetu-graphql-cli -h
Usage: graphcli [options]

Options:
  -h, --help
  -m, --mutation
```

Generally speaking, the tool accepts graphql queries in [district0x](https://github.com/district0x/graphql-query) [EDN](https://github.com/edn-format/edn) format on stdin and outputs JSON results on stdout

#### Examples

##### Query

``` bash
$ echo '[:search {:term "Ellen"}  [:name :email]]' | ./manetu-graphql-cli | jq .data.search
[
  {
    "name": "Ellen Cabane",
    "email": "ecabanemx@51.la"
  }
]
```

##### Mutation

Add the -m switch

``` bash
$ echo '[:create_iam_group {:name "test" :description "test" :mrn_roles ["mrn:iam:manetu.io:role:admin"]}] ' | ./manetu-graphql-cli -m -u http://manetu.haskins.net/graphql | jq .data
{
  "create_iam_group": "mrn:iam:piedpiper:group:ca3bbda6-9d97-46fb-94df-b9be1477dc4e"
}
```

### manetu-sparql-cli

``` bash
$ ./manetu-sparql-cli -h
Usage: graphcli [options]

Options:
  -h, --help
  --update VAULTLABEL
```

#### Examples

``` bash
$ cat <<EOF | ./manetu-sparql-cli
> PREFIX person: <http://www.w3.org/ns/person#>
>
> SELECT ?a ?v
>
> WHERE {
>     ?p person:Email "krangeley0@comsenz.com" .
>     ?p ?a ?v .
> }
> EOF
|--------------------------------------+----------------------------------------------|
|                  ?v                  |                      ?a                      |
|--------------------------------------+----------------------------------------------|
| <http://www.w3.org/ns/person#Person> | <http://www.w3.org/2000/01/rdf-schema#Class> |
| krangeley0@comsenz.com               | <http://www.w3.org/ns/person#Email>          |
| Karel                                | <http://www.w3.org/ns/person#FirstName>      |
| Rangeley                             | <http://www.w3.org/ns/person#LastName>       |
|--------------------------------------+----------------------------------------------|
```
