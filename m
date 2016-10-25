From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data on error
Date: Tue, 25 Oct 2016 22:57:41 +0200
Message-ID: <4579438.TdncW0phX6@wuerfel>
References: <20161017220342.1627073-1-arnd@arndb.de> <3945489.MQiL9ES5FK@wuerfel> <20161025191309.GX17252@sirena.org.uk>
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
In-Reply-To: <20161025191309.GX17252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday, October 25, 2016 8:13:09 PM CEST Mark Brown wrote:
> 
> Not enough information to check signature validity.	Show Details
> On Mon, Oct 24, 2016 at 10:37:53PM +0200, Arnd Bergmann wrote:
> 
> > I think my patch (the version I sent) should ideally make it into
> > v4.9 as a bugfix. This was the powerpc warning I saw from Olof's
> > autobuilder with the -Wmaybe-uninitialized warning added back, and
> > it's one of the actual bugs I found (though rather unlikely
> > to hit in practice).
> 
> > Merging with Heiner's patches should be trivial, and I'm pretty
> > sure we want the patch either way. Not sure if we need a backport,
> > it was introduced earlier this year in commit 6319a68011b8
> > ("spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()") as
> > I now found.
> 
> Sorry but I've lost track of which patches are being talked about here.
> If there's stuff for v4.9 can you send me a version that applies on
> Linus' tree and I'll merge that up into what's applied for -next?
> 

Done.

	Arnd
