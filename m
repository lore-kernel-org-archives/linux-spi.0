From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/6] ARM: add PrimeCell generic DMA to PL022
Date: Thu, 8 Apr 2010 00:11:31 -0600
Message-ID: <j2ifa686aa41004072311nd9206f85gd80ca745cea84b55@mail.gmail.com>
References: <1269905797-6756-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel@lists.infradead.org,
	Dan Williams <dan.j.williams@intel.com>,
	spi-devel-general@lists.sourceforge.net, linux-mmc@vger.kernel.org,
	STEricsson_nomadik_linux@list.st.com
To: Linus Walleij <linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1269905797-6756-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 29, 2010 at 5:36 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the PL022 UART driver with generic DMA engine support
> using the PrimeCell DMA engine interface. Also fix up the test
> code for the U300 platform.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> =A0arch/arm/mach-u300/dummyspichip.c | =A0 =A01 +
> =A0drivers/spi/amba-pl022.c =A0 =A0 =A0 =A0 =A0| =A0517 +++++++++++++=
++++++++++++++++++------

Hi Linus,

I really don't have much to say about this one.  It is entirely
contained within the amba-pl022 driver, so I don't have any core SPI
infrastructure concerns, and it is entirely dependent on the other
patches in your series, so it doesn't make sense to merge separately
through my SPI tree.

I have not tested or reviewed it at all, but I have no objections to
you merging it through whichever tree you merge the rest through.

g.
