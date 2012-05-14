From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] MIPS: OCTEON: Add register definitions for SPI host hardware.
Date: Mon, 14 May 2012 22:02:24 +0200
Message-ID: <CACRpkdaXgcYTxb4qHPkzsrU+x6=zg8mQGVxmgCV59R1s2eqn+g@mail.gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
	<1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
	David Daney <david.daney@cavium.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 11, 2012 at 11:34 PM, David Daney <ddaney.cavm@gmail.com> w=
rote:

> From: David Daney <david.daney@cavium.com>
>
> Needed by SPI driver.

That's not very verbose, plese tell atleast tell which SPI driver it's =
for.

> +union cvmx_mpi_cfg {
> + =A0 =A0 =A0 uint64_t u64;

The kernel already has a type (in <linux/kernel.h>) used in many places=
 in the
kernel, called "u64" so this gets very confusing.

Can you call it something else?

BTW: you could then s/uint64_t/u64 and use that u64.
(Some don't like the three-letter types so no big deal.)

> + =A0 =A0 =A0 struct cvmx_mpi_cfg_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t reserved_29_63:35;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t clkdiv:13;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena3:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena2:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena1:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena0:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t cslate:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t tritx:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t idleclks:2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t cshi:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t int_ena:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t lsbfirst:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t wireor:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t clk_cont:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t idlelo:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t enable:1;
> +#else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t enable:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t idlelo:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t clk_cont:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t wireor:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t lsbfirst:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t int_ena:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t cshi:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t idleclks:2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t tritx:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t cslate:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena0:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena1:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena2:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t csena3:1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t clkdiv:13;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint64_t reserved_29_63:35;
> +#endif

This boggles my mind, but I see there are many drivers doing this,
but using uint64_t looks overly scary.

Can't you break it apart using a set of u32's like in
drivers/net/ethernet/micrel/ksz884x.c?

Yours,
Linus Walleij
