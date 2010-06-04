From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: reinitialize transfer
	parameters for every message
Date: Fri, 4 Jun 2010 15:18:41 -0500
Message-ID: <AANLkTimNKcaW7zZya70qU2qG3dQ5sbgMZJUxfx02sIMu@mail.gmail.com>
References: <1275682387-10681-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1275682387-10681-1-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 4, 2010 at 3:13 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This patch fixes the setup_transfer logic to account for the case where
> multiple messages to different SPI devices are queued simultaneously.
> With the current logic, the second message in the queue will end up
> using the transfer parameters for the previous message in the queue.
>
> The fix is to reinitialize the transfer parameters for each message
> rather than only once on the first message.
>
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
> ---
> =A0drivers/spi/spi_bitbang.c | =A0 12 +++++++-----
> =A01 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
> index 5265330..8c0c0b8 100644
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -259,7 +259,6 @@ static void bitbang_work(struct work_struct *work)
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
> @@ -275,6 +274,8 @@ static void bitbang_work(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tm=
p;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs=
_change;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 status;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 do_setup =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 restore_param =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m =3D container_of(bitbang->queue.next, st=
ruct spi_message,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue);
> @@ -295,10 +296,11 @@ static void bitbang_work(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry (t, &m->transfers, tra=
nsfer_list) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* override speed or words=
ize? */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->speed_hz || t->bits_=
per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->speed_hz || t->bits_=
per_word) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_setup =
=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 restore_par=
am =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* init (-1) or override (1=
) transfer params */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (do_setup !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!setup=
_transfer) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0status =3D -ENOPROTOOPT;
> @@ -307,6 +309,7 @@ static void bitbang_work(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D=
 setup_transfer(spi, t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status=
 < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setup =
=3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* set up default clock po=
larity, and activate chip;
> @@ -368,9 +371,8 @@ static void bitbang_work(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->complete(m->context);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* restore speed and wordsize if it was ov=
erridden */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (do_setup =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (restore_param =3D=3D 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0setup_transfer(spi, NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setup =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* normally deactivate chipselect ... unle=
ss no error and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * cs_change has hinted that the next mess=
age will probably
> --
> 1.6.3.3

Grant -

I am resubmitting this patch with some changes given your previous
comments.  Basically the problem that David fixed with his original
patch still exists for the case where multiple messages to different
SPI devices on the same controller are in the work queue
simultaneously.  I have tested this on a board that has multiple SPI
devices on the same bus that use dramatically different transfer
parameters.  Without the patch a stress test fails quickly because the
driver ends up using the wrong transfer parameters.  With the patch
the problems are cleared up.

David -

Can you take a look at this and see if it is still in line with the
intent of your original fix?

Thanks,

Brian

---------------------------------------------------------------------------=
---
ThinkGeek and WIRED's GeekDad team up for the Ultimate =

GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the =

lucky parental unit.  See the prize list and enter to win: =

http://p.sf.net/sfu/thinkgeek-promo
