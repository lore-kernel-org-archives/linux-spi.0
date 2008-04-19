From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: script to find incorrect tests on unsigneds
Date: Sat, 19 Apr 2008 08:24:44 -0600
Message-ID: <20080419142444.GL20637@parisc-linux.org>
References: <4808C90A.5040600@tiscali.nl>
	<Pine.LNX.4.64.0804182101200.14832@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>,
	kernelnewbies-bounce-qDhp9YYfzQpg9hUCZPvPmw@public.gmane.org
To: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804182101200.14832-QfmoRoYWmW9knbxzx/v8hQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 18, 2008 at 09:08:55PM +0200, Julia Lawall wrote:
> I found 63 occurrences of this problem with the following semantic match
> (http://www.emn.fr/x-info/coccinelle/):
> 
> @@ unsigned int i; @@
> 
> * i < 0
> 
> I looked through all of the results by hand, and they all seem to be 
> problems.  In many cases, it seems like the variable should not be 
> unsigned as it is used to hold the return value of a function that might 
> return a negative error code, but I haven't looked into this in detail.
> 
> In the output below, the lines that begin with a single start contain a 
> test of whether an unsigned variable or structure field is less than 0.
> The output is actually generated with diff, but I converted the -s to *s 
> to avoid confusion.

> diff -u -p a/drivers/spi/spi_s3c24xx.c b/drivers/spi/spi_s3c24xx.c
> *** a/drivers/spi/spi_s3c24xx.c 2008-03-12 14:13:14.000000000 +0100
> @@ -127,7 +127,7 @@ static int s3c24xx_spi_setupxfer(struct 
>  
>  	div = (div / 2) - 1;
>  
> *	if (div < 0)
>  		div = 1;
>  
>  	if (div > 255)

Since this one's always in the range 0-255, it could probably be made
signed, but it's just as easy to make it work unsigned.

Reported-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Signed-off-by: Matthew Wilcox <willy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

diff --git a/drivers/spi/spi_s3c24xx.c b/drivers/spi/spi_s3c24xx.c
index b7476b8..b398cc9 100644
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
@@ -125,10 +125,10 @@ static int s3c24xx_spi_setupxfer(struct spi_device *spi,
 	/* is clk = pclk / (2 * (pre+1)), or is it
 	 *    clk = (pclk * 2) / ( pre + 1) */
 
-	div = (div / 2) - 1;
+	div /= 2;
 
-	if (div < 0)
-		div = 1;
+	if (div > 0)
+		div -= 1;
 
 	if (div > 255)
 		div = 255;

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
