From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Mon, 20 Sep 2010 13:42:53 -0400
Message-ID: <4C979D1D.1070707@criticallink.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<4C8EB795.1080607@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
	<201009140904.59555.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4D9B@dbde02.ent.ti.com>
	<4C8F7460.6050006@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1@dbde02.ent.ti.com>
	<4C94B9BD.4010606@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6F5385B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6F5385B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 9/20/2010 11:08 AM, Nori, Sekhar wrote:

> Hi Michael,
> 
> On Sat, Sep 18, 2010 at 18:38:13, Michael Williamson wrote:
>>
>> * I'm not sure I understand why there is a "intr_line" field in the platform
>> data and then a possibility to configure an "io_type" as interrupt or polled at
>> the chip select level.  I got burned by setting the "io_type" to SPI_IO_TYPE_INTR
>> and not setting "intr_line" to non-zero.  The probe just hung because it was
>> trying to use interrupts but never setting SPILVL register.  These fields aren't
>> mutually exclusive.  Is the intent to support a configuration with one chip select
>> running in polled mode and another in interrupt mode?  If so, then it seems the SPILVL
>> register logic needs some attention during each transfer.
> 
> The intr_line to be set is constant for the SoC. So, irrespective of what the
> individual devices on a given board choose to operate (interrupted, polled or DMA)
> the SoC code (da850.c) should setup the intr_line according to how the SPI interrupt
> is wired within the SoC. Can you clarify what you mean by "needs some attention during
> each transfer"?
> 


Ah... OK.  Thank you.  I now see that the SPILVL can be INT0 or INT1 for other davinci
SoCs like the DM644x.  For the da850 (OMAP-L138), SPILVL is valid only for INT1.  So 
pretty much, if your using a da850 (at least), intr_line has to be 1.  On other platforms,
it carries a lot more meaning...

Please ignore my ignorance...

Let me know if you want testing on the DMA portion of the patch (when your ready, of course).  

-Mike
