From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Mon, 11 Oct 2010 20:31:15 -0400
Message-ID: <4CB3AC53.2050701@criticallink.com>
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
	<4CB0665A.3000309@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302343630D8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302343630D8-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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

On 10/11/2010 12:57 PM, Nori, Sekhar wrote:
> Hi Mike,
> 
> On Sat, Oct 09, 2010 at 18:25:54, Michael Williamson wrote:
>> On 10/08/2010 03:22 PM, Michael Williamson wrote:
> 
>>> On 10/6/2010 11:37 AM, Nori, Sekhar wrote:
> 
>>>> On Mon, Sep 20, 2010 at 23:12:53, Michael Williamson wrote:
> 
>>>>
>>>> I just finished pushing the DMA related patches to the git branch[1].

[ stuff deleted ]

>>
>>>
>>>> Also, do you have patches adding SPI support for DA850 platform?
>>>> I can include these patches on this branch so others who will be
>>>> testing dont have to repeat the work.
>>>>
>>>
>>>
>>> I cloned your repository at [1] and published the additions needed to made to test it on the
>>> mitydsp-l138 platform (da850 based) at [2] (never mind the UART one at the end).  I had to add
>>> clock support for the spi devices and define the platform SPI resources/registration routines.
>>> I'd appreciate a quick peek at those to make sure that I didn't make any errors.  The spi
>>> registration may be refactorable (sp?) to support da830, I didn't look to closely at that.
>>>
>>> If any of it is usable, great.
> 
> Sure it is! I checked-in your patches with some modifications to my
> branch. The most notable change being usage of da8xx instead of da850 since
> the same code should work on da830 as well. Apart from this there are
> some cosmetic changes (patches squashed, some non-relevant hunks dropped
> etc). Do update the patches in your tree if you are OK with the changes.
> 

I think that the spi device names in the clk_lookup table in da830.c may need to be updated.  Right now
they are shown as "dm_spi.0".  Should they be "spi_davinci.o" and "spi_davinci.1"?

-Mike
