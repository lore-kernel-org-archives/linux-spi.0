From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/of: fix warning due to missing CONFIG_OF_DYNAMIC
 dependency
Date: Tue, 2 Dec 2014 20:46:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412022041580.16734@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


linux-next commit ce79d54ae447d65117303ca9f61ffe9dcbc2465d ("spi/of: Add OF
notifier handler") is causing the following warning during boot:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/spi/spi.c:2424 spi_init+0x8c/0xc8()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc6-next-20141201+ #77
Hardware name: NVIDIA Tegra132 Norrin (DT)
Call trace:
[<ffffffc00008a0f8>] dump_backtrace+0x0/0x12c
[<ffffffc00008a234>] show_stack+0x10/0x1c
[<ffffffc00056c474>] dump_stack+0x74/0xc4
[<ffffffc0000b1938>] warn_slowpath_common+0x98/0xcc
[<ffffffc0000b1a30>] warn_slowpath_null+0x14/0x20
[<ffffffc0007892fc>] spi_init+0x88/0xc8
[<ffffffc0000828c4>] do_one_initcall+0x88/0x1a8
[<ffffffc00076aad4>] kernel_init_freeable+0x140/0x1e8
[<ffffffc000567208>] kernel_init+0xc/0xd4
---[ end trace 39b2574b2cb43456 ]---

This was reported by Fengguang Wu on November 22:

https://lkml.org/lkml/2014/11/22/109

and November 28:

http://www.gossamer-threads.com/lists/linux/kernel/2059702

The warning is generated when the code tests the return value of
of_reconfig_notifier_register(), which returns -EINVAL.  This occurs
whenever CONFIG_OF_DYNAMIC is not set.  This warning will likely
affect any configuration with CONFIG_SPI && CONFIG_OF &&
!CONFIG_OF_DYNAMIC.

Fix by modifying the preceding kernel configuration option test to
test for CONFIG_OF_DYNAMIC, not CONFIG_OF.  This patch applies on
linux-next 20141201.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8a0e4b006a78..4431a578bd30 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2415,7 +2415,7 @@ static int __init spi_init(void)
 	if (status < 0)
 		goto err2;
 
-	if (IS_ENABLED(CONFIG_OF))
+	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
 
 	return 0;
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
