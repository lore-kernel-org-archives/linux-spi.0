From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCHv2 0/6] SPI: S3C64XX: bug fix and enhancements
Date: Wed, 08 Sep 2010 19:37:00 -0600
Message-ID: <5c15a9f3-0b99-44c3-b828-99c7b5deee0c@email.android.com>
References: <1283994931-23708-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1283994931-23708-1-git-send-email-jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



"Jassi Brar" <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

>Hi,
>  Here come six bug fixes and enhancements to the S3C64XX
>spi controller driver.
> The first 4 are bug/warning fixes, the last two are to
>enable the spi_s3c64xx.c to manage SPI controllers of newer
>Samsung SoCs with essentially the same IP but scalar logic
>moved into core clock management unit.
>
>--------8<--------
>Exact resend only with maintainers in '--to' and list in '--cc'
>assuming that is the standard pratice with spi-devel-general
>-------->8--------

Hi Jassi.  I've actually been working through these today (I'm not ignoring you, just dealing with back-to-school family issues which is why I'm slow).  You'll get emails as I merge them into my tree.

g.

>
>Thanks,
>Jassi
>

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
