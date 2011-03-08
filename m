From: Kevyn-Alexandre =?ISO-8859-1?Q?Par=E9?= <kapare-7qmld2CjetYf4mhTGKTGE9BPR1lH4CV8@public.gmane.org>
Subject: Re: Sending one byte transfers using SPI bus with linux-2.6.32
Date: Mon, 07 Mar 2011 20:00:34 -0500
Message-ID: <1299546034.2338.70.camel@andromeda>
References: <E4CEDCEF-66BE-4C94-A27D-5088882A1E0C@mac.com>
	<e9d13c1c-1e50-4b0c-bd95-60c8398142f6@email.android.com>
	<7974B5C3-662C-40A9-AB44-722A84190886@mac.com>
	<1299267497.2338.4.camel@andromeda> <1299268583.2338.6.camel@andromeda>
	<1299268719.2338.7.camel@andromeda>
	<B9012B37-7DAE-4D5D-B3F5-FFD675C89648@mac.com>
	<1299272196.2338.56.camel@andromeda>
	<1BCF7F7D-8E99-41A1-B134-9D7B478BC900@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: SPI Developer Mailing List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Elvis Dowson <elvis.dowson-ee4meeAH724@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1BCF7F7D-8E99-41A1-B134-9D7B478BC900-ee4meeAH724@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

A simple git diff should have save us some time ;)

git diff v2.6.32 v2.6.36 -- spidev_test.c
warning: refname 'v2.6.32' is ambiguous.
diff --git a/Documentation/spi/spidev_test.c
b/Documentation/spi/spidev_test.c
index 10abd37..16feda9 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -58,7 +58,7 @@ static void transfer(int fd)
        };
 
        ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
-       if (ret == 1)
+       if (ret < 1)
                pabort("can't send spi message");
 
        for (ret = 0; ret < ARRAY_SIZE(tx); ret++) {

-- kap

On Sun, 2011-03-06 at 21:45 +0400, Elvis Dowson wrote:
> Hi,
>         The problem was in the spidev_test.c program itself, in linux-2.6.32.
> 
> After applying the following patch taken from linux-2.6.34, 1 byte transfers work.
> 
> http://git.kernel.org/?p=linux/kernel/git/longterm/linux-2.6.34.y.git;a=blobdiff;f=Documentation/spi/spidev_test.c;h=16feda9014692a87a4996bf51d759ab9e7500ee5;hp=10abd3773e49122aab0dfad27f7cb2c91b8d5d08;hb=95b1ed2ac7ffe3205afc6f5a20320fbdb984da92;hpb=dda04c7bcf58cb02ac796beb1cf483aa5277f2af
> 
> Elvis Dowson



------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
