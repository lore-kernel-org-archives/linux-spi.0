From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drivers: spi-gpio: add support
	for controllers without MISO or MOSI pin
Date: Wed, 30 Jun 2010 04:00:43 -0700 (PDT)
Message-ID: <812239.26288.qm@web180311.mail.gq1.yahoo.com>
References: <1276841464-7984-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1276841464-7984-3-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



--- On Thu, 6/17/10, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Subject: [PATCH 2/2] drivers: spi-gpio: add support for controllers witho=
ut MISO or MOSI pin


I basically like this pair of patches.  I had a
very similar update a while back, which clearly
I never got around to submitting.  Can't find it
just now.


I think also that spi-gpio needs to be fairly close
to a reference implementation for SPI-on-Linux, and
this helps achieve that semantic goal.


> There are some boards that do not
> strictly follow SPI standard and use
> only 3 wires (SCLK, MOSI or MISO, SS) for connecting some simple auxiliary
> chips


Since SPI is a de-facto standard, it's routine
to have variances like (half duplex signaling
in some chips, and special SS/CS handling.  So
don't overstate the four-wire expectation.


> reads data from
> chip).
> =

> This patch adds support for such non-standard configuration
> in GPIO-based
> SPI controller. It has been tested in configuration without
> MISO pin.
> =

> Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

ACK.



> ---
>  drivers/spi/spi_gpio.c=A0 =A0
> =A0=A0=A0|=A0 101
> ++++++++++++++++++++++++++++++++++-------
>  include/linux/spi/spi_gpio.h |=A0 =A0 5 ++
>  2 files changed, 88 insertions(+), 18 deletions(-)
> =



---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
