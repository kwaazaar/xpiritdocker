FROM mcr.microsoft.com/dotnet/core/sdk:2.2 as build-env
WORKDIR /app
RUN dotnet new webapi
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
WORKDIR /app
COPY --from=build-env ./app/out .
ENTRYPOINT [ "dotnet", "app.dll" ]
