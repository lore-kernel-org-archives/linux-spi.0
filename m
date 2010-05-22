From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: reinitialize transfer
	parameters for each message
Date: Sat, 22 May 2010 03:27:00 -0600
Message-ID: <AANLkTimZ06_xg77TXLlRfWAPnVAEEcOwnN4u6XpEzAQ1@mail.gmail.com>
References: <1268175375-13970-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1268175375-13970-1-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Mar 9, 2010 at 4:56 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> It is possible that multiple messages for different SPI devices could
> be queued. =A0The transfer parameters are currently only set for the
> first message in the bitbang work queue. =A0If subsequent messages in
> the queue are for devices that do not have compatible transfer
> parameters (speed, phase, polarity, etc.) then those transfers will fail.
>
> The fix is to reinitialize the transfer parameters for each message
> rather than only once on the first message.
>
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
> ---
> =A0drivers/spi/spi_bitbang.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
> index f1db395..1e9247a 100644
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -258,7 +258,6 @@ static void bitbang_work(struct work_struct *work)
> =A0 =A0 =A0 =A0struct spi_bitbang =A0 =A0 =A0*bitbang =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0container_of(work, struct spi_bitbang, wor=
k);
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 flags;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setup =3D -1;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*setup_transf=
er)(struct spi_device *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct spi_transfer *);
>
> @@ -274,6 +273,7 @@ static void bitbang_work(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tm=
p;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs=
_change;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 status;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 do_setup =3D -1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m =3D container_of(bitbang->queue.next, st=
ruct spi_message,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue);

This doesn't look right.  Effectively moving the do_setup
initialization inside the loop completely short circuits the logic
around setup_transfer() calls.  In some cases this change will cause
setup_transfer() to get called twice back to back with no transfer in
between (after the last transfer if do_setup =3D=3D 1).

If the logic is wrong, then this patch should pull out and fix the bad
logic instead instead of force-overriding it.

g.

---------------------------------------------------------------------------=
---
