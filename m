From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Sat, 18 Sep 2010 09:08:13 -0400
Message-ID: <4C94B9BD.4010606@criticallink.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<4C8EB795.1080607@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
	<201009140904.59555.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4D9B@dbde02.ent.ti.com>
	<4C8F7460.6050006@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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

On 09/14/2010 09:26 AM, Nori, Sekhar wrote:
> Hi Mike,
> 
> On Tue, Sep 14, 2010 at 18:40:56, Michael Williamson wrote:
>> On 9/14/2010 3:14 AM, Nori, Sekhar wrote:
>>
>>> On Tue, Sep 14, 2010 at 11:34:59, Caglar Akyuz wrote:
>>>
>>>> Yes, your patches seems ok and mostly complete. I'm waiting for hardware to
>>>> test those, will let you know when I do some testing.
>>>
>>> Thanks! To save time, I haven't tested these patches myself. I have only made
>>> sure individual patches don't break the build. Was planning to test after
>>> the complete series is ready.
>>>
>>
>>
>> If it would help, If there are portions of the patch set that can be tested
>> with DMA disabled or something, I'd be willing to kick the tires.  I have
>> da850 hardware available.
> 
> Thanks for being brave and offering to help! Yes, interrupt and polled mode
> can be tried. Since a lot of testing has already happened on the original patch,
> I was planning to test the series only after it is complete. Any issues found can
> be narrowed down to the differences (which I hope will be justifiable).
> 
> Thanks,
> Sekhar

So I am testing with a configuration which is pretty much the same as the da850 EVM;
a SPI-NOR flash on the first chip select of SPI1.  Both poll and interrupt modes
work.  So far so good, and Brian's work really sorted out a bunch of questions 
I had looking at the original spi code.  Nice work, Nori, for break the patch
into logical blocks.  I do have a couple of comments:

* I'm not sure I understand why there is a "intr_line" field in the platform 
data and then a possibility to configure an "io_type" as interrupt or polled at
the chip select level.  I got burned by setting the "io_type" to SPI_IO_TYPE_INTR
and not setting "intr_line" to non-zero.  The probe just hung because it was
trying to use interrupts but never setting SPILVL register.  These fields aren't
mutually exclusive.  Is the intent to support a configuration with one chip select 
running in polled mode and another in interrupt mode?  If so, then it seems the SPILVL
register logic needs some attention during each transfer.

* As a (novice) user, I'd really like to see some comments / hints added to the 
../mach-davinci/include/mach/spi.h file to describe how all of the platform fields 
should be set.  Some of the fields aren't very obvious as to how to initialize 
them without having a data sheet on one screen and plowing through the 
driver on another.  This might have cleaned up my confusion on the first item.

Looking forward to seeing this moving into the mainline.  Thanks!

-Mike
