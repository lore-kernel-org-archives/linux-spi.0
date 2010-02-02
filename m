From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Fixed data sampling on the correct
	edge
Date: Tue, 2 Feb 2010 01:20:28 -0700
Message-ID: <fa686aa41002020020i7a3e0b1dpb3c65842e59f1677@mail.gmail.com>
References: <95F51F4B902CAC40AF459205F6322F0171E8D4987E@BMK019S01.emtrion.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Pietrek, Markus" <Markus.Pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D4987E-76KB/CMpcTeJqUQdFWzYuOuPKLVQfWtC@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 29, 2010 at 6:37 AM, Pietrek, Markus
<Markus.Pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org> wrote:
> Hi,
>
> it seems to me that the spi_sh_msiof.c driver configures REDG and TEDG wrongly. TEDG==0 outputs data at the **rising edge** of the clock and REDG==0 samples data at the **falling edge** of the clock. Therefore for SPI, TEDG must be equal to REDG, otherwise the last byte received is not sampled in the SPI mode 3
>
> The SH7723 HW Reference Manual explains the setting in Figure 20.20 and Figure 20.21 ("SPI Clock and data timing")
>
>
> Signed-off-by: Markus Pietrek <markus.pietrek-BU0Y/NROKIiELgA04lAiVw@public.gmane.org>
> Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Patch is whitespace damaged and so doesn't cleanly apply.  It's been
picked up anyway since this one is pretty trivial, but you should look
into fixing your mailer for sending patches.

Thanks,
g.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
