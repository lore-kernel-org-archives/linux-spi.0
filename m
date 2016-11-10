From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: rspi: avoid uninitialized variable access
Date: Thu, 10 Nov 2016 11:51:44 +0100
Message-ID: <5755979.RXybIODAnf@wuerfel>
References: <20161108134624.1905209-1-arnd@arndb.de> <58243D24.5080302@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58243D24.5080302@jinso.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, November 10, 2016 6:25:56 PM CET Hiep Cao Minh wrote:
> Hi Arnd,
> 
> Thanks for your fixed patch.
> 
> On 11/08/2016 10:46 PM, Arnd Bergmann wrote:
> > The newly introduced rspi_pio_transfer_in_or_our() function must
> > take either a valid 'rx' or 'tx' pointer, and has undefined behavior
> > if both are NULL, as found by 'gcc -Wmaybe-unintialized':
> >
> > drivers/spi/spi-rspi.c: In function 'rspi_pio_transfer_in_or_our':
> > drivers/spi/spi-rspi.c:558:5: error: 'len' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> Could you tell me what kind of GCC are you using?
> I'd like to reproduce it on my environment, too.
> I am using the Linaro's gcc of 
> "gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux".
> But there is no error message like this on my environment.

The warning is currently disabled in mainline Linux, but I'm trying to
address this and hope to still get a revert of 6e8d666e9253 ("Disable
"maybe-uninitialized" warning globally") into v4.9.

You can build with "make EXTRA_CFLAGS=-Wmaybe-uninitialized" in
the meantime.

	Arnd
