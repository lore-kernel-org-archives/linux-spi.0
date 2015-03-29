From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Sun, 29 Mar 2015 23:44:07 +0200
Message-ID: <C56F2148-7F42-4F15-8CB2-623A1D11BD49@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org> <1426755714-28130-2-git-send-email-kernel@martin.sperl.org> <550BAA89.5090707@wwwdotorg.org> <20150320095247.GE2869@sirena.org.uk> <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org> <20150325151611.GA3572@sirena.org.uk> <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org> <20150325165441.GI3572@sirena.org.uk> <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org> <20150325185007.GL3572@sirena.org.uk> <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org> <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org> <5516296A.2030505@wwwdotorg.org> <AB966507-3A94-4421-8153-AB4090E309AF@martin.sperl.org> <55177076.9000208@wwwdotorg.org> <74807CAA-A444-413B-9C9B-C3B06D5C18E6@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74807CAA-A444-413B-9C9B-C3B06D5C18E6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Stephen!

> all obviously an option but time consuming and an effort...
> Let us see if I find some time to test...

I started with the foundation kernels (as I know I was working
with those at the time):
3.8.13  - d996a1b91b2bf3dc06f4f4f822a56f4496457aa1 - WORKS
3.9.11  - d5572370289f698b101f3d0198b1c99f17f0d278 - WORKS
3.10.38 - 1b49b450222df26e4abf7abb6d9302f72b2ed386 - FAIL
3.12.36 - ee9b8c7d46f2b1787b1e64604acafc70f70191cf - FAIL

I will now try the same with the mainline kernel comparing 3.9
and 3.10 and maybe I can come up with something...
(unfortunately this is still quite time-consuming - 
even cross-compiling)

Note that some comments in commit messages of rpi-linux talk 
about some backport of code from 3.13, so this may be the real
reason...

Here the commit inside the foundation kernel that I refer to:

commit cff74f34502d46a6160dba6572db5f936cfa80ae
Author: ghollingworth <gordon-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Date:   Fri Mar 21 12:14:41 2014 +0000

    Support eMMC 5.1 cards

    Already upstream and in 3.13


>From the diff of drivers/mmc it also looks as if there is more 
error-handling code in the generic mmc code which may trigger
now...

One other issue with the upstream kernel is that for 3.9 there is
no spi-bcm2835 driver, so testing against does not work - it only
got included with 3.10, so testing is futile...

I will try to see if the commit 0385850e67359838f7d63 which is
right before cff74f34502d46a6160db is working or not and then
check if that commit introduced the issue.

Martin



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
