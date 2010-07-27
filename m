From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/mpc5121: register spi child
	devices of spi node
Date: Tue, 27 Jul 2010 00:21:02 -0600
Message-ID: <AANLkTiks6dc8Y5uav3N40E9v_T0JQ-+a9-ijci9hcQ2y@mail.gmail.com>
References: <1280185178-5002-1-git-send-email-agust@denx.de>
	<20100727061744.GB22765@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100727061744.GB22765-X57xyCW21FZ5l4KbKkTfamZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 27, 2010 at 12:17 AM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> Hi Anatolij,
>
> On Tue, Jul 27, 2010 at 12:59:38AM +0200, Anatolij Gustschin wrote:
>> Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
>> ---
>> =A0drivers/spi/mpc512x_psc_spi.c | =A0 10 +++++++++-
>> =A01 files changed, 9 insertions(+), 1 deletions(-)
>
> You should CC Grant Likely on this. He is now the de-facto maintainer of =
the
> SPI subsystem.

He did cc me.

g.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
