From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH linux-next v5 1/5] mtd: spi-nor: notify (Q)SPI controller
 about protocol change
Date: Mon, 31 Aug 2015 21:22:12 +0200
Message-ID: <CAOiHx=m0FhuH5BR-EYp4yQyB83yGRzdCFAPVfqB0b0+BvRE-6Q@mail.gmail.com>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com>
 <464fce12d75a5ba2105456cfd0a385b2d40305ba.1440580764.git.cyrille.pitchen@atmel.com>
 <CAOiHx=n+byfsbJNhnboqDEwhruOT8uKDJ+CcES7QBqPDLVAMsw@mail.gmail.com> <55DEDDBD.8060408@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Bean Huo (beanhuo)" <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
	shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55DEDDBD.8060408-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Thu, Aug 27, 2015 at 11:51 AM, Cyrille Pitchen
<cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> Hi Jonas,
>
> Le 26/08/2015 16:02, Jonas Gorski a =C3=A9crit :
>> On Wed, Aug 26, 2015 at 2:30 PM, Cyrille Pitchen
>> <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>>> Once the Quad SPI mode has been enabled on a Micron flash memory, t=
his
>>> device expects ALL the following commands to use the SPI 4-4-4 prot=
ocol.
>>> The (Q)SPI controller needs to be notified about the protocol chang=
e so it
>>> can adapt and keep on dialoging with the Micron memory.
>>
>> Doesn't that mean you need to disable quad mode on removal? Else the
>> following will break/fail:
>>
>> insmod atmel-quadspi.ko ~> spi-nor attaches -> sees micron -> enable=
s quad mode
>> rmmod atmel-quadspi.ko ~> spi-nor detaches
>> insmod atmel-quadspi.ko ~> spi-nor attaches -> fails to read the id
>> because flash is still in quad mode.
>>
>
> Indeed you're right such an issue does exist. So as you said one solu=
tion
> could be create a new function to "clean" what have been done by spi_=
nor_scan()
> then call it from remove() function of each driver calling spi_nor_sc=
an() from
> its probe().
> However we could also enhance the probing of the memory. It is true t=
hat Micron
> spi nor memories only accept SPI 4-4-4 commands once switched in quad=
 mode but
> actually they also provide a new command for this purpose:
> "Multiple I/O Read ID" (0xAF).
> Hence we could first try to probe using the regular Read ID (0x9F) co=
mmand then
> change the protocol, for instance to SPI 4-4-4, and try the 0xAF comm=
and.
> I don't think all combinations for command/protocol need to be tested=
: for
> Micron memories, their datasheets claim the 0x9F command is only supp=
orted in
> "extended spi mode" so for the SPI 1-1-1 protocol whereas the 0xAF co=
mmand
> only works in dual or quad modes.
> On the other hand Spansion memories still reply to the regular 0x9F c=
ommand in
> SPI 1-1-1 protocol even after their quad mode had been enabled.
> For other manufacturers, well... I don't know!

At least from the two spansion datasheets I looked at, there is no 2_
or 4_ mode for spansion flashes, and the quad mode only enables the
1_x_4 commands, where as on micron the 1_x_4 commands are always
available, and you only need to switch to DIO or QIO if you want to
use 2_2_2 or 4_4_4.

The question is how to detect if the READID command failed. Hopefully
it will result in an invalid command, and we get 0xff... (or 0x00...)
for the the id. And from there on we can first test 4_4_4 MIORDID (so
it won't a a full command on a DIO-enabled flash), and if that fails,
2_2_2. We need to tell the spi-nor controller to send these
accordingly though. I wonder if it might not be better to pass the
c_a_d as an additional parameter to the read_reg/write_reg etc call
backs, because they might change depending on the command used. E.g.
when using SPI_NOR_QUAD, we might want to make use of the quad page
program command (which is 1_1_4), but there is no 1_1_2 version, so we
cannot rely on a global "protocol" member for that, unless we want to
do a set_protocol before every command.

>
> Some of the advantages of the probe solution as compared to the remov=
e one are:
> - we don't need to patch all drivers using spi_nor_scan() to call a n=
ew
>   function from their remove().
> - it doesn't rely on the assumption that the spi-nor memory starts in
>   SPI 1-1-1 protocol. As a matter of fact the remove() won't be calle=
d for
>   built-in modules or in many (all ?) cases of reset. Moreover some b=
ootloaders
>   may have already enabled the quad mode before starting the Linux ke=
rnel. This
>   is what the sama5d2 romcode does when it is configured to boot from=
 a QSPI
>   memory.
>
> Anyway you're right and the issue need to be addressed but maybe in a=
nother
> dedicated patch ?

Yes, probably as a prerequisite to the quad mode on micron flashes. I
think we should also add a separate flag for the DIO/QIO modes for
micron flashes, as these are something separate from just the DOR/QOR
commands usually implied by SPI_NOR_DUAL/QUAD (well they are the same,
but work differently)

>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>> Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>>> Acked-by: Bean Huo <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
>>>  include/linux/mtd/spi-nor.h   | 13 +++++++++++++
>>>  2 files changed, 34 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/sp=
i-nor.c
>>> index c27d427fead4..c8810313a752 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -165,6 +165,22 @@ static inline int write_disable(struct spi_nor=
 *nor)
>>>         return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
>>>  }
>>>
>>> +/*
>>> + * Let the spi-nor framework notify lower layers, especially the d=
river of the
>>> + * (Q)SPI controller, about the new protocol to be used. Indeed, o=
nce the
>>> + * spi-nor framework has sent manufacturer specific commands to a =
memory to
>>> + * enable its Quad SPI mode, it should immediately after tell the =
QSPI
>>> + * controller to use the very same Quad SPI protocol as expected b=
y the memory.
>>> + */
>>> +static inline int spi_nor_set_protocol(struct spi_nor *nor,
>>> +                                      enum spi_protocol proto)
>>> +{
>>> +       if (nor->set_protocol)
>>> +               return nor->set_protocol(nor, proto);
>>> +
>>> +       return 0;
>>
>> Shouldn't the default assumption be that it won't support it? Also i=
t
>> might make sense to first check if it's supported before enabling it
>> in the chip, so that we don't enable something just to then find out
>> we can't back out of it.
>>
>> I also wonder if we need an extra flag for that as at least SPI has
>> RX_{DUAL,QUAD} and TX_{DUAL,QUAD} separated, so in theory there coul=
d
>> be a controller that supports quad read, but not quad write, so we
>> shouldn't be using the quad mode in that case. m25p80 currently sets
>> SPI_NOR_{DUAL,QUAD} only based on SPI_RX_{DUAL,QUAD}, so that would
>> then fail.
>>
>> At least the n25q32 seems to support the "boring" 1_1_2 and 1_1_4
>> commands, so these should work in case the spi controller does not
>> support quad tx, but quad rx.
>>
>> So maybe an additional flag for the "full" dual/quad modes would be =
in order.
>>
>
> My first thought was to return -ENOSYS when the set_protocol() callba=
ck is not
> implemented but logically none of the already existing drivers implem=
ents it.
> So I made this new callback optional. This way, micron_quad_enable() =
works the
> exact same way as before for all the existing drivers so no regressio=
n or side-
> effect should be introduced by this patch.

If they don't implement the callback, then they won't know that they
are supposed to use a different protocol, so change will definitely
have broken them. Therefore an error return value and or a dev_warn
would be IMHO better.

> So more accurate checks should be done before calling set_quad_mode()=
=2E Maybe
> the range of values for the mode parameter of spi_nor_scan() is too s=
mall.
> SPI_NOR_QUAD doesn't allow to make the difference between SPI protoco=
ls 1-1-4,
> 1-4-4 or 4-4-4. Knowing the exact set of protocols supported by both =
the
> controller and the memory could help making the right decision and ch=
oosing the
> best suited Fast Read command.
> The RX_{DUAL_QUAD} and TX_{DUAL,QUAD} flags from the spi->mode in the=
 m25p80
> driver provide more information than the limited "mode" argument of
> spi_nor_scan().

so from the controller side we need to know whether it can do
RX_{DUAL,QUAD} and TX_{DUAL,QUAD}; but for the flash supported
commands we have a bit more variety (the x_y_z you mentioned).

=46unny enough, once we are on QIO on spansion, there is no difference
anymore between FAST (0x0b), QOR (0x6b) and QIOR (0xeb), they all work
in the 4_4_4 mode.

>> Last but not least, the protocol probably should be stored somewhere
>> in the nor struct, so that users don't have to store it themselves (=
I
>> assume they will need to check it for each command again to know if
>> the cmd/address should be send in serial or quad mode).
>>
>>
> I agree with you, this could be an improvement for some spi controlle=
r drivers :)
>
>> Jonas
>>
>
> thanks for your review!
>
> Best regards,
>
> Cyrille


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
