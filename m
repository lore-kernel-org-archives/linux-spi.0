From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data on error
Date: Mon, 24 Oct 2016 22:37:53 +0200
Message-ID: <3945489.MQiL9ES5FK@wuerfel>
References: <20161017220342.1627073-1-arnd@arndb.de> <f364c025-91c0-6625-e2a3-d00baf17d71c@gmail.com> <20161024184543.GR17252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <heiner.kallweit@web.de>,
        Nobuteru Hayashi <hayashi.nbb@ncos.nec.co.jp>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024184543.GR17252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, October 24, 2016 7:45:43 PM CEST Mark Brown wrote:
> On Mon, Oct 24, 2016 at 08:36:37PM +0200, Heiner Kallweit wrote:
> > Am 24.10.2016 um 19:27 schrieb Mark Brown:
> 
> > > This doesn't apply against current code, please check and resend.
> 
> > The not yet reviewed part of my patch series from Oct 2nd,
> > namely "[PATCH 07/11] spi: fsl-espi: fix and improve reading
> > from RX FIFO" replaces the code in question.
> > There's more to fix like removing polling from the ISR.
> > If you prefer to apply Arnd's fix first I'd rebase the open part
> > of the patch series and resend it.
> 
> If there are dependencies you should mention them when you resend (in
> general you should always mention any unapplied or cross tree
> dependencies when sending things).

I think my patch (the version I sent) should ideally make it into
v4.9 as a bugfix. This was the powerpc warning I saw from Olof's
autobuilder with the -Wmaybe-uninitialized warning added back, and
it's one of the actual bugs I found (though rather unlikely
to hit in practice).

Merging with Heiner's patches should be trivial, and I'm pretty
sure we want the patch either way. Not sure if we need a backport,
it was introduced earlier this year in commit 6319a68011b8
("spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()") as
I now found.

	Arnd
