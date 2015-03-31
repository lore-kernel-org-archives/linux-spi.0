From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Tue, 31 Mar 2015 16:49:32 +0200
Message-ID: <E13569A5-33E5-48ED-B25F-EC7374E144C9@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <5516296A.2030505@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5516296A.2030505-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 28.03.2015, at 05:09, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> As for testing: I have also tried to test with mmc_spi, but I have not
>> been able to make that driver work reliably in any recent kernel
>> versions.
>> Most of the time I see timeouts - and with lots of different SD-cards...
>> 
>> IIRC the last time I tested it successfully was with 3.12.
> 
> It'd be great if you could use "git bisect" to track down the change
> that broke this.

Here some info on my testing with the upstream kernels:
3.12.0 - 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52 - WORKS
3.13.0 - d8ec26d7f8287f5788a494f56e8814210f0e64be - FAILS
which is what I had suspected.

Bisection between these shows the responsible commit is:

[sperl@build linux-upstream]$ git bisect bad
0589342c27944e50ebd7a54f5215002b6598b748 is the first bad commit
commit 0589342c27944e50ebd7a54f5215002b6598b748
Author: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Date:   Tue Oct 29 23:36:46 2013 -0500

    of: set dma_mask to point to coherent_dma_mask

    Platform devices created by DT code don't initialize dma_mask pointer to
    anything. Set it to coherent_dma_mask by default if the architecture
    code has not set it.

    Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

:040000 040000 805e59ffdb181a71299f354ee7cca727dad4778a 5445e765b6be497d45af3f108c3f38ef6aabb44a M	drivers

It is a surprising result and does not really explain the situation.

I did check the last working (0589342c2794) and non 
working (13ccacd5945a) commits again after cleaning the builds
and rebuilding from scratch.

I did not believe this so I reran the bisect just to make sure - 
this time also rebuilding the dtb every time.

Now I went back to 4.0.rc5+ and patched it as follows:
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -179,9 +179,10 @@ static void of_dma_configure(struct device *dev)
         * Set it to coherent_dma_mask by default if the architecture
         * code has not set it.
         */
+/*
        if (!dev->dma_mask)
                dev->dma_mask = &dev->coherent_dma_mask;
-
+*/
        ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
        if (ret < 0) {
                dma_addr = offset = 0;

And now it works - the SD card gets detected immediately,
I can mount it and everything...

Is this something we need to fix in bcm2835 by using the "correct"
coherent_dma_mask?

Still I do not understand why we need dma_mask not set for the
mmc_spi driver and how it influences the behaviour...

Martin

P.s: Note that I have built like this:
make bcm2835_defconfig
echo "CONFIG_MMC_SPI=y" >> .config

using the following diff to enable mmc_spi in the device-tree:
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -50,3 +50,14 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&spi {
+	status = "okay";
+	sd1: sd@1 {
+		reg = <1>;
+		status = "okay";
+		compatible = "spi,mmc_spi";
+		voltage-ranges = <3200 3500>;
+		spi-max-frequency = <8000000>;
+	};
+};


Note if you want to repeat this, then you have to boot with the
SD card removed, because otherwise mmc0 will be the sd card on
the SPI bus and not the "native" SD card...

I have now also patched out the changes introduces with the patch
in a 4.0rc and the result is 

here the bisect log:
git bisect start
# good: [5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52] Linux 3.12
git bisect good 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52
# bad: [d8ec26d7f8287f5788a494f56e8814210f0e64be] Linux 3.13
git bisect bad d8ec26d7f8287f5788a494f56e8814210f0e64be
# bad: [42a2d923cc349583ebf6fdd52a7d35e1c2f7e6bd] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect bad 42a2d923cc349583ebf6fdd52a7d35e1c2f7e6bd
# good: [4b4d2b463461f1b86fd89353184e6f2938e7566b] Merge tag 'h8300-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect good 4b4d2b463461f1b86fd89353184e6f2938e7566b
# bad: [5cbb3d216e2041700231bcfc383ee5f8b7fc8b74] Merge branch 'akpm' (patches from Andrew Morton)
git bisect bad 5cbb3d216e2041700231bcfc383ee5f8b7fc8b74
# good: [eeab517b68beb9e044e869bee18e3bdfa60e5aca] Merge tag 'sound-3.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good eeab517b68beb9e044e869bee18e3bdfa60e5aca
# bad: [07eb6597c059d9276c8dc7cd0401083ed66ad714] MAINTAINERS: remove Richard Purdie as backlight maintainer
git bisect bad 07eb6597c059d9276c8dc7cd0401083ed66ad714
# good: [85b656cf1560e27a89354a23f2c10ba229d2f173] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/linux-leds
git bisect good 85b656cf1560e27a89354a23f2c10ba229d2f173
# bad: [a8f70de37bbb991033208edff7758d997d68db37] ocfs2: use bitmap_weight()
git bisect bad a8f70de37bbb991033208edff7758d997d68db37
# good: [b5b4bb3f6a11f9c37b6d53138244f2ffe5bacd12] of: only include prom.h on sparc
git bisect good b5b4bb3f6a11f9c37b6d53138244f2ffe5bacd12
# good: [355e62f5ad12b005c862838156262eb2df2f8dff] of/irq: Fix potential buffer overflow
git bisect good 355e62f5ad12b005c862838156262eb2df2f8dff
# bad: [74dac2ed699cbe1dee0e4e7891619d53a5f2632f] of: irq: Fix interrupt-map entry matching
git bisect bad 74dac2ed699cbe1dee0e4e7891619d53a5f2632f
# bad: [f0e1bfbd2d1b0900a56c25cea35be2467a5cfc32] of: Add AU Optronics Corporation vendor prefix
git bisect bad f0e1bfbd2d1b0900a56c25cea35be2467a5cfc32
# good: [67aeb39a173b5c172c75c5b9f1844853aec16eb4] of: Add vendor prefix for Cadence
git bisect good 67aeb39a173b5c172c75c5b9f1844853aec16eb4
# good: [13ccacd5945aa5ce81d8566f57587e95fbd90742] of: add vendor prefix for PHYTEC Messtechnik GmbH
git bisect good 13ccacd5945aa5ce81d8566f57587e95fbd90742
# bad: [0589342c27944e50ebd7a54f5215002b6598b748] of: set dma_mask to point to coherent_dma_mask
git bisect bad 0589342c27944e50ebd7a54f5215002b6598b748
# first bad commit: [0589342c27944e50ebd7a54f5215002b6598b748] of: set dma_mask to point to coherent_dma_mask

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
