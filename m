From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
Date: Wed, 10 Nov 2010 09:34:42 -0500
Message-ID: <4CDAAD82.9090007@ti.com>
References: <20101110044530.GB4110@angua.secretlab.ca>
	<79124.87409.qm@web180307.mail.gq1.yahoo.com>
	<20101110062310.GB7431@angua.secretlab.ca>
Reply-To: cyril-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20101110062310.GB7431-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

On 11/10/2010 01:23 AM, Grant Likely wrote:
> On Tue, Nov 09, 2010 at 10:16:22PM -0800, David Brownell wrote:
>>
>>> I thought the point of this device was that a single [SSP] device
>>> hosted a
>>> pair of multi-function serial interfaces, with each
>>> implementing a
>>> separate function.
>>
>> function chosen based on what the board needs.
>> Codec interface, SPI, GPIO, etc.
>>
>>   If so, then it makes sense for the
>>> base driver to
>>> register child devices of the appropriate kinds.
>>
>> I'd normally say board setup registers them; a
>> "core"driver can't know what children would be needed.
>>
>> But the point I was making was about code factoring
>> not driver setup.  When  the functions don't have
>> much commonality, they might as well just write to
>> the relevant registers instead of expecting to have
>> a non-register programming interface (of dubious
>> generality of a "core" driver, but much complexity).
>>
>> Easier just to have children use registers directly,
>> in several similar cases.  Less overhead, too.
> 
> I guess it depends on how much overlap/interlock there is between the
> multiple channels.  If there is shared context, then that is a
> stronger argument for a shared api.  Cyril, what say you?
> 

The channels (or ports) in this case are not very well separated out.
The registers for these ports are interleaved, and in some cases
different bits of the same register are meant for different ports.

Second, with the exception of GPIO (which essentially bit bangs), all
other functions would follow the same flow, i.e. set stuff up (mode,
iosel), load up a sequence, kick off execution, and wait for completion.
 I thought it made sense to provide these pieces in a shared driver.

Regards
Cyril.
