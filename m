From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Sat, 09 Oct 2010 08:55:54 -0400
Message-ID: <4CB0665A.3000309@criticallink.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<4C8EB795.1080607@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
	<201009140904.59555.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4D9B@dbde02.ent.ti.com>
	<4C8F7460.6050006@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1@dbde02.ent.ti.com>
	<4C94B9BD.4010606@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6F5385B@dbde02.ent.ti.com>
	<4C979D1D.1070707@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302342050C7@dbde02.ent.ti.com>
	<4CAF6F86.40201@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4CAF6F86.40201-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 10/08/2010 03:22 PM, Michael Williamson wrote:
> Hi Sekhar,
> 
> On 10/6/2010 11:37 AM, Nori, Sekhar wrote:
> 
>> Hi Mike,
>>
>> On Mon, Sep 20, 2010 at 23:12:53, Michael Williamson wrote:
>>>
>>> Let me know if you want testing on the DMA portion of the patch (when your ready, of course).
>>
>> I just finished pushing the DMA related patches to the git branch[1].
>> I have not tested yet, but feel free to give it a go (maybe I will get
>> lucky again!).
>>
> 
> 
> I gave it a go for our platform.  The good news is, polled and interrupt driven mode still work!  
> The bad news is that DMA mode hangs up the kernel on the first read attempt, stalled waiting 
> for the transfer completion notification (hmmm.... I think this was a spot where things were 
> tweaked a bit? :) )
> 
> I'll see if I can narrow it down some more if you don't get to it first.
>  

I think I found it.  This patch (below, and on [2]) got it working for me. The Rx DMA
size on transfer requests with no receive buffer provided needs to match the requested
size (and the transmit size), not the size of the temporary buffer.  All good as the
DMA address increment is 0 in this case.

I'll try to do some more testing next week, but so far so good.

---
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 662ebbe..8206df1 100755
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -632,13 +632,11 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		 * source address never increments.
 		 */
 
-		if (t->rx_buf) {
+		rx_buf_count = davinci_spi->rcount;
+		if (t->rx_buf)
 			rx_buf = t->rx_buf;
-			rx_buf_count = davinci_spi->rcount;
-		} else {
+		else
 			rx_buf = davinci_spi->rx_tmp_buf;
-			rx_buf_count = sizeof(davinci_spi->rx_tmp_buf);
-		}
 
 		t->rx_dma = dma_map_single(&spi->dev, rx_buf, rx_buf_count,
 							DMA_FROM_DEVICE);

> 
>> Also, do you have patches adding SPI support for DA850 platform?
>> I can include these patches on this branch so others who will be
>> testing dont have to repeat the work.
>>
> 
> 
> I cloned your repository at [1] and published the additions needed to made to test it on the
> mitydsp-l138 platform (da850 based) at [2] (never mind the UART one at the end).  I had to add 
> clock support for the spi devices and define the platform SPI resources/registration routines.  
> I'd appreciate a quick peek at those to make sure that I didn't make any errors.  The spi 
> registration may be refactorable (sp?) to support da830, I didn't look to closely at that.
> 
> If any of it is usable, great.
> 
>> Thanks,
>> Sekhar
>>
>> [1] http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite
>>
> 
> 
> [2] http://support.criticallink.com/gitweb/?p=linux-davinci.git;a=shortlog;h=refs/heads/spi-testing
> 
> -Mike
