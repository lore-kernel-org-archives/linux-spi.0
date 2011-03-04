From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Sending one byte transfers using SPI bus with linux-2.6.32
Date: Fri, 04 Mar 2011 08:59:46 -0700
Message-ID: <e9d13c1c-1e50-4b0c-bd95-60c8398142f6@email.android.com>
References: <E4CEDCEF-66BE-4C94-A27D-5088882A1E0C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Elvis Dowson <elvis.dowson-ee4meeAH724@public.gmane.org>,
	SPI Developer Mailing List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E4CEDCEF-66BE-4C94-A27D-5088882A1E0C-ee4meeAH724@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



Elvis Dowson <elvis.dowson-ee4meeAH724@public.gmane.org> wrote:

>Hi,
>I modified the spidev_test.c program and I find that when sending data,
>I have to specific a minimum transfer length of 2, for a message. 
>
>If I specify an array size of 1, no transfer takes place.

What backend spi master driver/device are you using?  Single byte transfers should work. It may be a bug/limitation of the driver.

g.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
