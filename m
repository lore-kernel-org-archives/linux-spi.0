From: Girish KS <girishks2000@gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: add missing check for polling mode
Date: Tue, 2 Jul 2013 12:22:14 +0530
Message-ID: <CAKrE-KcOVCipc9BfmVgvg5BAgKv2=V0F6WhFqFWP6vsLy7OOKA@mail.gmail.com>
References: <1372316213-30671-1-git-send-email-ks.giri@samsung.com>
	<20130627111518.GX27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130627111518.GX27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 27, 2013 at 4:45 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 27, 2013 at 12:26:53PM +0530, Girish K S wrote:
>> After the patch "spi/s3c64xx: Fix non-dmaengine usage"
>> with commit id 563b444e33810f3120838620c990480304e24e63
>> submitted by Mark Brown, the spi device detection in polling
>> mode breaks. This revealed the missing check for polling during
>> dma prepare. This patch adds the missing check.
>
> Applied with a fixed commit message - since the dmaengine stuff was
> already in mainline at the time that polling mode was added the isse was
> that the patch hadn't been tested with current mainline code.

Hello Mark, This patch is missing in your pull request for 3.11. is it
possible to add it?
