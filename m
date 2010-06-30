From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drivers: spi-gpio: add support
	for controllers without MISO or MOSI pin
Date: Wed, 30 Jun 2010 14:29:58 -0600
Message-ID: <AANLkTilw1Oc9tG9M55A9dedvxRAN3gWPQMSPzZyThrj7@mail.gmail.com>
References: <1276841464-7984-3-git-send-email-m.szyprowski@samsung.com>
	<812239.26288.qm@web180311.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <812239.26288.qm-4JhmkcZgSkmORdMXk8NaZPu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 30, 2010 at 5:00 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>
>
> --- On Thu, 6/17/10, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Subject: [PATCH 2/2] drivers: spi-gpio: add support for controllers with=
out MISO or MOSI pin
>
>
> I basically like this pair of patches. =A0I had a
> very similar update a while back, which clearly
> I never got around to submitting. =A0Can't find it
> just now.
>
>
> I think also that spi-gpio needs to be fairly close
> to a reference implementation for SPI-on-Linux, and
> this helps achieve that semantic goal.
>
>
>> There are some boards that do not
>> strictly follow SPI standard and use
>> only 3 wires (SCLK, MOSI or MISO, SS) for connecting some simple auxilia=
ry
>> chips
>
>
> Since SPI is a de-facto standard, it's routine
> to have variances like (half duplex signaling
> in some chips, and special SS/CS handling. =A0So
> don't overstate the four-wire expectation.
>
>
>> reads data from
>> chip).
>>
>> This patch adds support for such non-standard configuration
>> in GPIO-based
>> SPI controller. It has been tested in configuration without
>> MISO pin.
>>
>> Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> ACK.

Picked up and pushed out to my test-spi branch if anyone wants to
test.  Will push out to linux-next by the end of the week.

git://git.secretlab.ca/git/linux-2.6 test-spi

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
