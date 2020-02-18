From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Tue, 18 Feb 2020 11:17:11 +0800
Message-ID: <debe614e-e5fe-edd4-8890-1b993d605f85@linux.intel.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214130952.GI4827@sirena.org.uk>
 <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
 <20200217170901.GS9304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
        cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200217170901.GS9304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 18/2/2020 1:09 AM, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 05:18:10PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 14/2/2020 9:09 PM, Mark Brown wrote:
>>> This will unconditionally handle the interrupt regardless of if the
>>> hardware was actually flagging an interrupt which will break shared
>>> interrupts and the fault handling code in genirq.
>> Yes, you're correct, it doesn't check unconditionally, will update the
>> INT flag in the INT_STATUS register after successful completion of
>> read/write operation.
>> but in this case it is dedicated to qspi-interrupt,not shared with any other
>> HW/SW interrupts.
> Currently, on the system you're looking at.  Given that this is already
> a widely reused IP there's no guarantee that this will always be the
> case, and like I say even without sharing it also defeats the fault
> handling code.
Got it, Thanks! a lot
will take care of it, even though it is not present in the system 
current,  to avoid future conflicts.
Flagging and check to be added  to avoid  if the interrupt raises from 
shared  devices.

Regards
Vadivel
