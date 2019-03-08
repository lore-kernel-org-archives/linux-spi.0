From: "Xiao, Jin" <jin.xiao@intel.com>
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
Date: Fri, 8 Mar 2019 15:28:10 +0800
Message-ID: <11f165e9-ef53-edb9-cec2-e30ad2b440b5@intel.com>
References: <20190307072424.18820-1-jin.xiao@intel.com>
 <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
 <20190307160924.GE6529@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: yanmin.zhang@intel.com, linux-kernel@vger.kernel.org,
 haojian.zhuang@gmail.com, linux-spi@vger.kernel.org, bo.he@intel.com,
 daniel@zonque.org, robert.jarzmik@free.fr, jin.xiao@intel.com,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190307160924.GE6529@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi

On 3/8/2019 12:09 AM, Mark Brown wrote:
> On Thu, Mar 07, 2019 at 05:26:53PM +0200, Jarkko Nikula wrote:
>> On 3/7/19 9:24 AM, xiao jin wrote:
>>> The patch is to do cs again if spi-pxa2xx restar the SSP during
>>> pxa2xx_spi_transfer_one()
>> Hmm.. please correct me if I'm wrong but pxa2xx_spi_unprepare_transfer()=
 is
>> called always when there is no more messages pending and the spi core sh=
ould
>> have deasserted the CS already?
> Yes.

I try to describe the situation in more detail.

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cpu0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 =A0=A0=A0 cpu1

 =A0=A0=A0 =3D> spi_transfer_one_message

 =A0=A0=A0 =3D> __spi_pump_messages

 =A0=A0=A0 =3D> __spi_sync

 =A0=A0=A0 =3D> spi_sync

 =A0=A0=A0 =3D> spi_sync_transfer.constprop.2

 =A0=A0=A0 =3D> spi_write

 =A0=A0=A0 =3D> fm1388_spi_burst_write

 =A0=A0=A0 =3D> fm1388_fw_loaded

 =A0=A0=A0 =3D> request_firmware_work_func

 =A0=A0=A0 =3D> process_one_work

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =3D> pxa2xx_spi_unprepare_transfer

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =3D> spi_pump_messages

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =3D> kthread_worker_fn

Yes, the spi core has de-asserted the CS before the =

pxa2xx_spi_unprepare_transfer(). The problem on my side is that the new =

transfer will restart the SSP in pxa2xx_spi_transfer_one(). The spi core =

has asserted the CS again before restart the SSP.=A0 In my test the CS =

assert before the restart SSP can't ensure the spi transfer working =

correctly.

>>> @@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_co=
ntroller *master,
>>>    	if ((pxa2xx_spi_read(drv_data, SSCR0) !=3D cr0)
>>>    	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
>>>    	    !=3D (cr1 & change_mask)) {
>>> +		/* It needs to deassert the chip selection
>>> +		 * firstly before restart the SPP */
>>> +		need_cs_change =3D true;
>>> +		cs_deassert(spi);
>> I think code comes here at the beginning of each transfer so will be hit
>> multiple times before pxa2xx_spi_unprepare_transfer() if SPI message
>> consists of multiple transfers.
>> This makes me wondering if the device driver setting up the "struct
>> spi_transfer" is maybe missing the cs_change flag set for transfers befo=
re
>> last one in case HW needs CS toggling between transfers? For instance wh=
at
>> following drivers are doing with the cs_change flag:
>> drivers/char/tpm/tpm_tis_spi.c: tpm_tis_spi_transfer()
>> drivers/input/touchscreen/ad7877.c: ad7877_read(), ad7877_read_adc()
> Right, this really feels like it's fixing the wrong thing.

I check the cs_change flag in the spi_transfer_one_message(). The =

cs_change flag is used in two cases. If the transfer is the last one it =

is used to keep the CS assert. If the transfer is not the last one it's =

used to generate the 10us pulse and then de-assert the CS. In my case =

the transfer is the last one and it can work correctly if I re-assert =

the CS after restart the SSP in the pxa2xx_spi_transfer_one() which is =

called from spi_transfer_one_message(). From my experiments both =

cs_change flag cases in the spi_transfer_one_message() can't help the =

problem. I am not sure if I fully understand your point.
