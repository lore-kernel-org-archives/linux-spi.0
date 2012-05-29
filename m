From: "Langer Thomas (LQDE CPE AE SW)" <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
Date: Tue, 29 May 2012 13:05:18 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6049FCE@MUCSE039.lantiq.com>
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org>
	<20120525233845.BD93C3E0BD2@localhost> <4FC0DEEC.8050204@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4FC0DEEC.8050204-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Grant, hello John,

John Crispin wrote on=A02012-05-26:
> =

>> What exactly does this mean?  How does it not support any other type
>> of SPI peripheral?  SPI is a really simple protocol, so what is it
>> about this hardware that prevents it being used with other SPI
>> hardware?
>> =

>> I see a big state machine that appears to interpret the messages and
>> pretend to be an SPI slave instead of telling linux about the real
>> device.  /me wonders if it should this instead be a block device
>> driver?
>> =

> Thomas will need to comment on this part
> =

The hardware is an "EBU" (External Bus Unit) for different type of memories =

and flashes (NOR, NAND and serial).
One of the features of this EBU is the "execute in place" for serial flashe=
s.
This shows that there is some logic in the hardware for automatic reading,
all other actions must be done using a specific cmd register.

Even if there are some restrictions from the hardware state machine,
the goal was to use the standard driver for serial flash devices (m25p80).
Otherwise, with a dedicated block device driver, we would have to duplicate
much of this code and had to maintain an own list of supported flash chips.

I hope this reason is good enough for getting this driver accepted.

Best Regards,
Thomas


---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
