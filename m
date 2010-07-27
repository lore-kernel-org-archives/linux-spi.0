From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/mpc5121: register spi child
	devices of spi node
Date: Tue, 27 Jul 2010 00:37:38 -0600
Message-ID: <AANLkTik9GYDGi3jnMdPdyOa6sFv4bo_+4b-RWMq7nW6x@mail.gmail.com>
References: <20100727061744.GB22765@jasper.tkos.co.il>
	<298403.16600.qm@web180305.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <298403.16600.qm-g47maUHHHF9+W+z1sZEpBPu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 27, 2010 at 12:28 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrot=
e:
> There are things wrong with the concept of this
> particular patch. =A0First, that it's mpc5121-only.
> Second, that it's not already handled as part of
> registering the platform's SPI devices.

The reason is that in this use case the platform code doesn't provide
a list of spi devices.  The list of devices is contained in the
flattened device tree, and the data is parsed after the spi bus is
created.

But you're right; the fact that each driver has to explicitly call
this function is a problem.  I plan to write a patch to remove all
those calls in each driver and call it from the core spi core instead.

g.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
