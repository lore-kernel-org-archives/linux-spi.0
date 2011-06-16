From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/5] dw_spi: rework message processing
Date: Thu, 16 Jun 2011 11:38:05 -0600
Message-ID: <BANLkTinaP5w4N-pnoWMor-JWQfC8mc9yWg@mail.gmail.com>
References: <1308158588-17249-1-git-send-email-dirk.brandewie@gmail.com>
 <1308158588-17249-4-git-send-email-dirk.brandewie@gmail.com>
 <20110616220003.7ac89d56@feng-i7> <4DFA3D30.2070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Feng Tang <feng.tang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>, alan@linux.intel.com,
	alek.du@intel.com
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DFA3D30.2070909@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 16, 2011 at 11:28 AM, Dirk Brandewie
<dirk.brandewie@gmail.com> wrote:
> On 06/16/2011 07:00 AM, Feng Tang wrote:
>>
>> Hi Dirk,
>>
>> IMHO, the patch is too big, it contains too many changes to the orig=
inal
>> drivers, and we can't see clearly what you've changed to each logica=
l
>> code part or section, If possible, could you separate this patch to
>> several small ones in a logical way.
>>
>> First, I have some questions, what devices have you tested with this
>> patch?
>> high speed, low speed? Do you have any performance data to show the
>> benefit
>> of this change? Current dw_spi driver has been tested with many devi=
ces,
>> so
>> to not break them or cause obvious regression, we have to be cautiou=
s.
>
> See Thread with grant for list of environments where it has been test=
ed.
> The boot time of the platforms it is being used on decreased 2-5 seco=
nds
> with no regressions reported. =A0It has been in use/under test for ~3=
 months
> in various Meego and Android builds. =A0It clears all the bugs report=
ed
> against the driver that I am aware of. =A0If you can give me pointers=
 to
> teams/projects that are using v2.6.37+ kernels I would be more that h=
appy to
> provide them with patches for their kernel to ensure we get the most
> comprehensive test possible.
>
>>
>> Here are some general comments according to the commit logs:
>> 1. I think the threaded irq handling is a good idea. And let driver =
chose
>> to
>> =A0 =A0use poll or interrupt is good, some other spi controller driv=
er has
>> used
>> =A0 =A0that way for a long time
>> 2. Why you remove the cs_change code, in some case, the controller i=
s only
>> =A0 =A0be used by one device, we don't need do the config for every =
single
>> =A0 =A0spi_transfer
>
> There is no guarantee that all the transfers in a given spi_message h=
ave the
> same values for =A0speed_hz, bits_per_word, cs_change and delay_usecs=
 atleast
> nothing I could find put that restriction in place. Since we need to =
deal
> with possible changes (although unlikely) it gets rid some state we n=
eed to
> maintain and makes the code path common for all transfers.
>
>> 3. Why do you remove the chip select control code, dw_spi controller=
 hw
>> has
>> =A0 =A0some problem in chip select controller by SER, and thus many =
devices
>> has
>> =A0 =A0to use external GPIO has their chip select, this is real worl=
d usages!
>
> Which devices/platforms are you referring to? =A0I was unable to find=
 any
> platforms or client drivers using this functionality. If they are not=
 public
> please respond internally. =A0In any case it is mute since I already =
agreed to
> put is back in in my response to Grant.
>
>> 4. I saw you enable both TX/RX interrupt when doing interrupt transf=
er,
>> spi
>> =A0 =A0devices' TX/RX are born to be simutaneous, when one word is s=
ent over
>> =A0 =A0TX line, a RX word will be received from RX line, so both the=
 orignal
>> =A0 =A0interrupt transfer handling written by me and the later optim=
ization
>> =A0 =A0from Alek Du only enable TX interrupt, which will only genera=
te half of
>> =A0 =A0IRQs comparing to enble both TX/RX, this is huge when the dat=
a rate is
>> =A0 =A0several Mb per second
>
> I the current driver the txfltr register is set to 0 (FIFO empty) in =
the
> interrupt transfer case which will drop chip select every FIFO length=
 bytes.
>
> In my transfer setup the RX FIFO interrupt is set to a value lower th=
an the
> TX threshold which will keep both interrupts from firing at the same =
time.
>
> The TX interrupt will drive the transfer until there are less than
> tx_threshold bytes left to transfer then by the RX interrupt to drive=
 the
> remainder of the transfer without dropping chip select.

Be careful here.  Can you guarantee that the kernel will process the
IRQ before the FIFO drains?  If not, then you'll need something more
reliable.

g.
