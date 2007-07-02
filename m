From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
Date: Mon, 02 Jul 2007 23:00:50 +0900 (JST)
Message-ID: <20070702.230050.59033318.anemo@mba.ocn.ne.jp>
References: <20070627.222458.27955527.anemo@mba.ocn.ne.jp>
	<200706300953.20156.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706300953.20156.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, 30 Jun 2007 09:53:19 -0700, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > +	txx9spi_cs_func(spi, c, 0, 1000000000 / 2 / spi->max_speed_hz);
> 
> You still use this confusing A/2/B syntax.  Please
> rewrite that using one "/" and one "*".  (And there
> is similar usage elsewhere.)

Replaced with "(NSEC_PER_SEC / 2) / spi->max_speed_hz".

> These checks here should be in txx9_spi_transfer(), where
> returning EINVAL will do some good.  The single caller to
> this routine doesn't even look at its return value ... and
> returning without issuing the message's completion callback
> is just a bug.

Oh it was really a bug.  Fixed.

> That speed check is wrong.  There's no reason two transfers
> shouldn't have different speeds ... e.g. flash chips often
> have speed limits in certain bulk reads, which don't apply
> to other operations.

Done.

> Also, you can't replace per-transfer speed checks with one
> for the overall message... each transfer could have a
> very different speed.

Done.  Now per-transfer speed_hz and bits_per_word are really supported.

> Here's where the (corrected) checks for each spi_transfer in the
> message belong:  if the message is invalid, don't even queue it,
> just return -EINVAL.

Done.

> > +	if (clk_enable(c->clk)) {
> 
> Minor comment:  if power management is a concern, you might
> consider leaving the clock disabled except when transfers
> are active or you're accessing controller registers.  On
> most chips, leaving a clock enabled all the time (like this)
> means power is needlessly consumed.  (This isn't wrong, just
> sub-optimal in terms of power reduction.)

Well, I did not change this since we can not really stop the
"spi-baseclk" anyway.  But thank you for comment.

> > +	master->num_chipselect = 0;	/* unlimited: any GPIO numbers */
> 
> No, actually it means "no chipselects" as I said before;
> the fact that this works right now is a bug that will be
> fixed at some point.  INT_MAX would allow any GPIO.

Done.  I chose "(u16)INT_MAX" to silence a sparse warning.

> ... almost mergeable!

Let's go take3 !

---
Atsushi Nemoto

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
