From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
Date: Mon, 14 May 2012 11:13:41 -0700
Message-ID: <4FB14B55.4070604@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>	<1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Daney <ddaney.cavm@gmail.com>,
	devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAM=Q2csSQWbCOCQpubDok1=hmPvHU0MTEUg+-FGhp91=O5L6Hw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/13/2012 10:46 PM, Shubhrajyoti Datta wrote:
> Hi David,
> A few comments.
>
> On Sat, May 12, 2012 at 3:04 AM, David Daney<ddaney.cavm@gmail.com>  wrote:
[...]

>> +
>> +#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
> This could be given a miss. As it is less meaningful once accepted.


Well, this leads to the question, what is the purpose of the 
'MODULE_VERSION()' macro?  If I use that, I need to populate it with a 
value.

>
[...]
>> +static void octeon_spi_wait_ready(struct octeon_spi *p)
>> +{
>> +       union cvmx_mpi_sts mpi_sts;
>> +       unsigned int loops = 0;
>> +
>> +       do {
>> +               if (loops++)
>> +                       __delay(500);
> Could we allow  have a non-busy loop here?
>

We could, but I thought about it and chose not to.

The SPI hardware can queue a maximum of 9 bytes (72 bits) before 
software has to take action.  That works out to 3.6 uS at a 20MHz clock 
rate.  Sleeping, scheduling to a different task, taking an interrupt and 
then switching back to this task will likely not be faster than that.

At lower clock rates, it would make more sense, but it adds complexity 
to the driver.  We can always revisit this decision if it proves to be a 
problem.

David Daney
