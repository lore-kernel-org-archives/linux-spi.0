From: Michael Weiser <michael.weiser@gmx.de>
Subject: Re: [PATCH v6] ARM: sun4i: spi: Allow transfers larger than FIFO size
Date: Thu, 21 Jul 2016 13:27:01 +0200
Message-ID: <20160721112701.GB6610@weiser.dinsnail.net>
References: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dev@linux-sunxi.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
To: Olliver Schinagl <oliver@schinagl.nl>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi all,

On Sat, Aug 08, 2015 at 09:41:51PM +0200, Olliver Schinagl wrote:

> Alexandru sent this patch over a year and a half ago, and I believe several
> tree's have been carrying it since. We've been using this patch on an
> Olimex OLinuxIno Lime1 and Lime2 using the mmc-spi driver to access SD cards
> without problems. So bumping this and adding my

I also have a need for this addition since it makes an ENC28J60 SPI
ethernet controller work on the Cubieboard2. I've successfully tested it
with 4.6.3 where it still applies cleanly.

(There's is a very minor conflict when applying against current Linus
master (EINVAL was changed to EMSGSIZE). I can supply a rebased version
if so desired.)

What is keeping the patch from being merged (i.e. into mainline)?

Thanks!
Michael

> Tested-by: Olliver Schinagl <oliver@schinagl.nl>

Tested-by: Michael Weiser <michael.weiser@gmx.de>

> Changes from v5as warned by checkpatch. No functional changes.
>  * Added some newlines to make checkpatch happy. No functional changes.

> Changes from v4:
>  * use min3() instead of two if statements in sun4i_spi_fill_fifo()
>  * fix trivial whitespace issue in if statement in sun4i_spi_handler()
>  * use consistent style in assigning 'reg' in the added functions.

> Alexandru Gagniuc (1):
>   ARM: sun4i: spi: Allow transfers larger than FIFO size

>  drivers/spi/spi-sun4i.c | 76 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 9 deletions(-)
-- 
Thanks,
Michael
