From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Mon, 8 Sep 2008 15:50:23 -0700
Message-ID: <200809081550.23600.david-b@pacbell.net>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<48A5D44D.6040106@whoi.edu>
	<20080815223307.02db86aa@vsauder-lx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080815223307.02db86aa-W37fpRALFaH6NKmgiXY+hA0JkcsJGQge@public.gmane.org>
Content-Disposition: inline
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

On Friday 15 August 2008, Vernon Sauder wrote:
> >I think the =A0"1" and "15" above correspond to threshold register values
> >of "0" and "14"; that is the above numbers are the number of words in
> >the FIFO that trigger the interrupt/service request.
> =

> All this still leaves me slightly confused. (And I didn't even touch the
> dma_burst_size member yet.) I assume that the correct value for all of
> these settings must be determined empirically, not just theoretically.

I think you're probably right, although I'd say "optimum" not "correct".
Incorrect values should be rejected (or at least ignored) by the driver.


> How can I tell what the correct or optimum values are? Do I just use a
> performance test on the Flash chip or MMC device? Or can I look at the
> logic analyzer output and see what they should be? Or is there a debug
> printk that needs to be enabled?

I think the idea was that since the PXA hardware manuals don't
offer suggestions, this was a "punt it all to the board maintainer"
kind of solution.

- dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
