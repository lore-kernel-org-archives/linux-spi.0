From: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Subject: [PATCH] spi: mark device nodes only in case of successful instantiation
Date: Fri, 14 Oct 2016 21:31:13 +0200
Message-ID: <20161014193113.29275-1-ralf@ramses-pyramidenbau.de>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instantiated SPI device nodes are marked with OF_POPULATE. This was
introduced in bd6c164. On unloading, loaded device nodes will of course
be unmarked. The problem are nodes the fail during initialisation: If a
node failed during registration, it won't be unloaded and hence never be
unmarked again.

So if a SPI driver module is unloaded and reloaded, it will skip nodes
that failed before.

Skip device nodes that are already populated and mark them only in case
of success.

Fixes: bd6c164 ("spi: Mark instantiated device nodes with OF_POPULATE")
Signed-off-by: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
Hi,

imagine the following situation: you loaded a spi driver as module, but
it fails to instantiate, because of some reasons (e.g. some resources,
like gpios, might be in use in userspace).

When reloading the driver, _all_ nodes, including previously failed
ones, should be probed again. This is not the case at the moment.
Current behaviour only re-registers nodes that were previously
successfully loaded.

This small patches fixes this behaviour. I stumbled over this while
working on a spi driver.

  Ralf

 drivers/spi/spi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 200ca22..f96a04e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1604,12 +1604,15 @@ static void of_register_spi_devices(struct spi_master *master)
 		return;
 
 	for_each_available_child_of_node(master->dev.of_node, nc) {
-		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+		if (of_node_check_flag(nc, OF_POPULATED))
 			continue;
 		spi = of_register_spi_device(master, nc);
-		if (IS_ERR(spi))
+		if (IS_ERR(spi)) {
 			dev_warn(&master->dev, "Failed to create SPI device for %s\n",
 				nc->full_name);
+			continue;
+		}
+		of_node_set_flag(nc, OF_POPULATED);
 	}
 }
 #else
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
