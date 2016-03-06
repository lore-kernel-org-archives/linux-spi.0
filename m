From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/rockchip: fix endian mode for 16-bit transfers" to the spi tree
Date: Sun, 06 Mar 2016 18:37:14 +0700
Message-ID: <E1acWzq-0003gj-Ly@finisterre>
References: <1457258657-19154-1-git-send-email-al.kochet@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457258657-19154-1-git-send-email-al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/rockchip: fix endian mode for 16-bit transfers

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0277e01aebc8895198a4717ccaf7e4fcf39ada78 Mon Sep 17 00:00:00 2001
From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 6 Mar 2016 13:04:17 +0300
Subject: [PATCH] spi/rockchip: fix endian mode for 16-bit transfers

16-bit transfers must be in big endian mode on wire.

Signed-off-by: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6cdb4d81d66c..9a5c51764833 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -506,7 +506,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	int rsd = 0;
 
 	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
-		| (CR0_SSD_ONE << CR0_SSD_OFFSET);
+		| (CR0_SSD_ONE << CR0_SSD_OFFSET)
+		| (CR0_EM_BIG << CR0_EM_OFFSET);
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
