From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: add support for aeroflex gaisler spimctrl
Date: Wed, 4 May 2011 08:46:21 -0600
Message-ID: <BANLkTino_-YyDSZJspPz0xAFX+5LDcbwCw@mail.gmail.com>
References: <1304023295-5829-1-git-send-email-jan@gaisler.com>
	<4DBC09FB.5070406@gaisler.se> <4DC166B0.4090001@gaisler.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jan Andersson <jan-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4DC166B0.4090001-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 4, 2011 at 8:46 AM, Jan Andersson <jan-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org> wrote:
> On 04/30/2011 03:09 PM, Jan Andersson wrote:
>> Grant Likely wrote:
>>>> + =A0 if (!hw->base) {
>>>> + =A0 =A0 =A0 =A0 =A0 err =3D -EBUSY;
>>>> + =A0 =A0 =A0 =A0 =A0 goto exit;
>>>> + =A0 }
>>>> +
>>>> + =A0 /* check current hw state. if controller is busy, leave it alone=
 */
>>>> + =A0 status =3D ag_spim_read(hw->base + AG_SPIM_STAT);
>>>> + =A0 if (status & AG_SPIM_STAT_BUSY) {
>>>> + =A0 =A0 =A0 =A0 =A0 err =3D -EBUSY;
>>>> + =A0 =A0 =A0 =A0 =A0 goto exit_iounmap;
>>>> + =A0 }
>>>> +
>>>> + =A0 /* save control register value to keep settings */
>>>> + =A0 hw->ctrl =3D ag_spim_read(hw->base + AG_SPIM_CTRL);
>>>> +
>>>> + =A0 /* irq is optional */
>>>> + =A0 hw->irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
>>>
>>> The irq should already be populated in the platform_device resource
>>> table. =A0You shouldn't need to call irq_of_parse_and_map().
>>>
>>
>> I tried replacing the call with platform_get_irq() but did not get a
>> sensible value back. I am not familiar with how these structures get
>> populated. If I would follow how the irq is obtained in other drivers
>> for these SoCs I would have done: hw->irq =3D pdev->archdata.irqs[0];
>>
>> I thought the call to irq_of_parse_and_map was cleaner, and the end
>> result is the same. If the use of irq_of_parse_and_map is not acceptable
>> I will need to dig deeper.
>>
>
> I checked with a colleague who is more familiar with the driver layer
> and SPARC port. IORESOURCE_IRQ will not work on SPARC. It looks like the
> proper fix for this is to get rid of pdev_archdata in the SPARC port and
> change all the SPARC drivers. That will be done but it may take a while
> to complete and get it accepted so it would be great if we could allow
> the use of irq_of_parse_and_map(pdev->dev.of_node, 0); for the time being.

okay.

g.

---------------------------------------------------------------------------=
---
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network =

management toolset available today.  Delivers lowest initial =

acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
