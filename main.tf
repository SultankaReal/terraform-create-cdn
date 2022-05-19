# Create CDN origin group
# Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/cdn_origin_group

resource "yandex_cdn_origin_group" "new_group" {
    name = "My new group"
    use_next = true // If the option is active (has true value), in case the origin responds with 4XX or 5XX codes, use the next origin from the list.
    origin {
        source = "ya.ru"
    }
    origin {
        source = "yandex.ru"
    }
    origin {
        source = "goo.gl"
    }
    origin {
        source = "amazon.com"
      backup = false
    }
}


# Create CDN resource
# Link to terraform documentation - https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/cdn_resource

resource "yandex_cdn_resource" "new_resource" {
    depends_on = [yandex_cdn_origin_group.new_group]
    cname = "cdn1.yandex-example.ru" //CDN endpoint CNAME, must be unique among resources.
    active = false //Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients.
    origin_protocol = "https"
    secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
    origin_group_id = yandex_cdn_origin_group.new_group.id
}

