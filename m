From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi_mpc83xx: handle odd transfer
	sizes
Date: Wed, 10 Sep 2008 17:11:15 -0700
Message-ID: <200809101711.15376.david-b@pacbell.net>
References: <1221041160-19342-1-git-send-email-jacmet@sunsite.dk>
	<200809101405.39285.david-b@pacbell.net>
	<001801c9138e$ea5a4cc0$bf0ee640$@Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <001801c9138e$ea5a4cc0$bf0ee640$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
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

On Wednesday 10 September 2008, Joakim Tjernlund wrote:
> =

> > -=A0=A0=A0=A0=A0return mpc83xx_spi->count;
> > +=A0=A0=A0=A0=A0return 0;
>
> This hunk should probably stay untouched, not sure the mpc83xx_spi->count=
 always
> is zero in case of TX errors.

Good point.  I'll just change the "return len" to "return -EINVAL"
then and leave the rest alone.  Fault handling could stand to be
reworked in many places here ... if there's a TX (or RX) error,
this version always returns -EMSGSIZE!

Likewise, these particular faults would be better off getting
reported before mpc83xx_spi_transfer() queues the transfer.
Aborting mid-transfer when you knew up front that you'd have
to do so ... not friendly!

- Dave
 =




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
