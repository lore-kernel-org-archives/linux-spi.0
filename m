From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable chan between each SPI
	transfer
Date: Sun, 27 Jun 2010 00:08:02 -0600
Message-ID: <AANLkTinO3kndb9bIAGlz4-h2TW64NGthHBRcVlE3gqun@mail.gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD83846FB@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C249BA1.8010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
	roman.tereshonkov@nokia.com, linux-arm-kernel@lists.infradead.org
To: jason <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C249BA1.8010808@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 25, 2010 at 6:05 AM, jason <jason77.wang@gmail.com> wrote:
> roman.tereshonkov@nokia.com wrote:
>>
>>
>>
>
> [snip]
>>>
>>> -----Original Message-----
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0c =3D 0;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if=
 (c =3D=3D 0 && tx =3D=3D NULL) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 omap2_mcspi_set_enable(spi, 0);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx++ =
=3D __raw_readl(rx_reg);
>>>
>>
>> Why do you do this?
>> Reading the last word from the shift register buffer leads to the
>> receiving new data to the buffer.
>> The channel needs to be disabled before the last word reading.
>>
>>
>>
>
> Yes, you are right. If this patch can be accepted, i will remove those
> changes in the V2 patch.
> Please see my email replying grant likely's questions.

Hi Jason.

I'm assuming I can ignore this patch and wait for your V2.  I'll still
want an ack from other omap spi users before I apply it though.

g.

>
> Thanks,
> Jason.
>>
>>
>>>
>>> @@ -646,7 +641,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct
>>> spi_transfer *xfer)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&spi->dev, "EOT =
timed out\n");
>>> =A0 =A0 =A0 =A0}
>>> out:
>>> - =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
>>> + =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 0);
>>> =A0 =A0 =A0 =A0return count - c;
>>> }
>>>
>>> @@ -894,7 +889,6 @@ static void omap2_mcspi_work(struct work_struct
>>> *work)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D spi->controller_state;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd =3D spi->controller_data;
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry(t, &m->transfers, tr=
ansfer_list) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->tx_buf =3D=3D NUL=
L && t->rx_buf =3D=3D NULL &&
>>> t->len) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =
=3D -EINVAL;
>>> @@ -931,6 +925,8 @@ static void omap2_mcspi_work(struct work_struct
>>> *work)
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi_write_chconf0(spi,=
 chconf);
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(sp=
i, 1);
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->len) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned=
 =A0 =A0 =A0 =A0count;
>>>
>>> --
>>> 1.5.6.5
>>>
>>>
>>>
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
