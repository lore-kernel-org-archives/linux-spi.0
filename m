From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] spi: spi-davinci: Fix DMA API usage in davinci
Date: Thu, 22 Mar 2012 21:31:03 +0530
Message-ID: <CAM=Q2cvfDe8U+iReAG0N3Rv3k99BMzUoMAJWJ+8PzstZY0hZYA@mail.gmail.com>
References: <1332240009-2011-1-git-send-email-shubhrajyoti@ti.com>
	<20120320162335.65ACD3E2834@localhost>
	<DF0F476B391FA8409C78302C7BA518B631802D1C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Shankarmurthy,
	Akshay" <akshay.s-l0cyMroinI0@public.gmane.org>,
	Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Datta,
	Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B631802D1C-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Sekhar,

On Thu, Mar 22, 2012 at 8:08 PM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> Hi Grant,
>
> On Tue, Mar 20, 2012 at 21:53:34, Grant Likely wrote:
>> On Tue, 20 Mar 2012 16:10:09 +0530, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>> > The driver uses NULL for dma_unmap_single instead of
>> > the struct device that the API expects.
>> >
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> > ---
>> > I do not have the board ,untested.
>>
>> Can someone with this hardware please test?
>
> Akshay from TI tested this on DA850 EVM. He doesn't have
> this e-mail so posting the tested-by on his behalf:
>
> Tested-by: Shankarmurthy, Akshay < akshay.s-l0cyMroinI0@public.gmane.org>

Thanks Akshay,

>
> Thanks,
> Sekhar
>
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
