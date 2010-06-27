From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: reinitialize transfer
	parameters for every message
Date: Sun, 27 Jun 2010 00:51:33 -0600
Message-ID: <AANLkTil9nKF_tDNVl8cGliBbP-w0iQsLNxuKK6maYiuC@mail.gmail.com>
References: <1275682387-10681-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Vitaly Wool <vwool-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Vitaly and David, can you please take a look at this.  You both know
this code better than I, and I'd like as second opinion. (see my
comments below)

On Fri, Jun 4, 2010 at 2:13 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
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

Hi Brian,

It seems to me that with this change that always forces
setup_transfer() to be run at the beginning of a message, that this
setup_transfer() call becomes completely superfluous and can be
removed.  Why bother setting up the default parameters for the last
device when all transfers to that device have completed?

The rest of the patch does seem correct.  One note: the patch looks
like it removes an optimization to avoid setup_transfer() whenever
possible.  I don't have any problem with this myself.  In general I
prefer straightforward coding, and I think that each setup_transfer
hook should be smart enough anyway not to reconfigure things that
don't need to be change.  However, I'd like to know more about the
original intent of this code.  Is this just and optimization, or am I
missing something?

> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setup =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* normally deactivate chipselect ... unle=
ss no error and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * cs_change has hinted that the next mess=
age will probably

However, looking at this code deeper, I wonder if there is another
bug.  Let me add the lines that finish the above comment and
manipulate the cs:

>                 * be for this chip too.
>                 */
>                if (!(status =3D=3D 0 && cs_change)) {
>                        ndelay(nsecs);
>                        bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
>                        ndelay(nsecs);
>                }

It seems that it is trying to provide the option for leaving the CS
line active at the end of a transfer.  However, I don't see any code
that verifies that when cs_change =3D=3D 0 at the end of a message, that
the next message will definitely be for the same device.  It could be
that the CS won't get explicitly deactivated before a message for
another device begins.

Granted, ->chipselect() will still get called regardless to set the
new device chip select, which /should/ implicitly clear the previous
chip select, but it won't get exactly the same behaviour and it could
result in weird transfer failures.  Thoughts?

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
