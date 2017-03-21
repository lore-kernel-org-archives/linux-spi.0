From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pl022: remove nonexistent properties from DT binding example" to the spi tree
Date: Tue, 21 Mar 2017 18:46:17 +0000
Message-ID: <E1cqOnR-0001Kb-2t@debutante>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Shiraz Hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        Brijesh Singh <brijeshkumar.singh-5C7GfCeVMHo@public.gmane.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>,
        Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>,
        Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
        Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170320095721.6724-1-borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pl022: remove nonexistent properties from DT binding example

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

>From e6a72e057fa3e0ad38ec59c4779647a7bd390a37 Mon Sep 17 00:00:00 2001
From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 20 Mar 2017 10:57:18 +0100
Subject: [PATCH] spi: pl022: remove nonexistent properties from DT binding
 example

The properties "pl022,hierarchy" and "pl022,slave-tx-disable" were
initially proposed till patch V4 [1] but then discarded in V5 [2]
when the patch set was taken over by another developer, as
explained in patch history in [3].
The above properties never landed in mainline code but were then
listed in the binding example by a following commit dc715452e914
("spi: pl022: use generic DMA slave configuration if possible")
and later on they were copy-paste in some board's DT.

Remove the nonexistent properties from the example.
Also remove a spaces-only line at the end of the file.

[1] https://lkml.org/lkml/2012/7/9/421
[2] https://lkml.org/lkml/2012/8/21/427
[3] https://lkml.org/lkml/2012/8/21/436

Signed-off-by: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi_pl022.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
index 4d1673ca8cf8..2692a5726c3f 100644
--- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -56,9 +56,7 @@ Example:
 			spi-max-frequency = <12000000>;
 			spi-cpol;
 			spi-cpha;
-			pl022,hierarchy = <0>;
 			pl022,interface = <0>;
-			pl022,slave-tx-disable;
 			pl022,com-mode = <0x2>;
 			pl022,rx-level-trig = <0>;
 			pl022,tx-level-trig = <0>;
@@ -67,4 +65,3 @@ Example:
 			pl022,duplex = <0>;
 		};
 	};
-	
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
