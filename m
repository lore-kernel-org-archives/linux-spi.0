From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] spi/spi_s3c64xx: Move to subsys_initcall()
Date: Wed, 8 Sep 2010 18:37:59 +0900
Message-ID: <AANLkTimvc52yXuMFN2=qLKX1MSyTum1GHnLdDW8dMR=2@mail.gmail.com>
References: <1283855357-15179-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTim=ArPyqC7K-aaer97deGeR6yU-FS1Hpm3D_1ER@mail.gmail.com>
	<20100908091242.GB31253@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jassi Brar <jassi.brar@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100908091242.GB31253@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 8, 2010 at 6:12 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Sep 08, 2010 at 01:55:39PM +0900, Jassi Brar wrote:
>> On Tue, Sep 7, 2010 at 7:29 PM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>> > Allow the use of the S3C64xx SPI controller with things like PMICs by
>> > moving the init up to subsys_initcall().
>
>> Couldn't any user ever need to load it as a module?
>> If no, we might as well drop the s3c64xx_spi_exit and s3c64xx_spi_remove
>
> This doesn't prevent building as a module - when built as a module
> subsys_initcall() is identical to module_init(), the change will only
> affect the order in which things are done when the code is built into
> the kernel otherwise it's a noop.
I didn't know that, thanks for the info.

Acked-by: Jassi Brar <jassi.brar@samsung.com>
