From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
Date: Tue, 22 May 2012 17:01:51 -0600
Message-ID: <CACxGe6sY++3jreWbQ4jvmmkbeUitMgYYd-oa4x+_49OMyV7O+Q@mail.gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
	<1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
	<20120520055436.13AF03E03B8@localhost>
	<20120520060802.03CE73E03B8@localhost> <4FBBECC2.10503@gmail.com>
	<CACxGe6tYQVfPRtXxmYF2OPYcEFu+x4-_uzFta9f3mwu=xUrt=g@mail.gmail.com>
	<4FBC1807.4050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	"alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4FBC1807.4050402-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Cool, thanks.

g.

On Tue, May 22, 2012 at 4:49 PM, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 05/22/2012 01:09 PM, Grant Likely wrote:
>>
>> On Tue, May 22, 2012 at 1:45 PM, David Daney<ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> =A0wrote:
>>>
>>> On 05/19/2012 11:08 PM, Grant Likely wrote:
>>>>
>>>>
>>>> On Sat, 19 May 2012 23:54:36 -0600, Grant
>>>> Likely<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> =A0 =A0wrote:
>>>>>
>>>>>
>>>>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>> =A0wrote:
>>>>>>
>>>>>>
>>>>>> From: David Daney<david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>>>>>
>>>>>> When generating MODALIASes, it is convenient to add things like "spi=
:"
>>>>>> or "i2c:" to the front of the strings. =A0This allows the standard
>>>>>> modprobe to find the right driver when automatically populating bus
>>>>>> children from the device tree structure.
>>>>>>
>>>>>> Add a prefix parameter, and adjust callers. =A0For
>>>>>> of_register_spi_devices() use the "spi:" prefix.
>>>>>>
>>>>>> Signed-off-by: David Daney<david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>>>>
>>>>>
>>>>>
>>>>> Applied, thanks. =A0Some notes below...
>>>>
>>>>
>>>>
>>>> Wait... why is this necessary?
>>>
>>>
>>>
>>> Because in of_register_spi_devices() in of_spi.c, you do:
>>>
>>> =A0 =A0 =A0 =A0request_module(spi->modalias);
>>>
>>> The string passed to request_module() must have the "spi:" prefix.
>>
>>
>> How about modifying the call to request_module() to include the prefix
>> also? =A0I think that would be a simpler change overall. =A0Would that
>> work?
>
>
> It seems to. =A0I just sent such a patch in a new thread.
>
> David Daney



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
