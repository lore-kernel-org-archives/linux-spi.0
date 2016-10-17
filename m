From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH v2 2/2] i2c: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 22:16:54 +0300
Message-ID: <83F4A55C-C0E5-45A7-A768-E4D322B8A4B0@konsulko.com>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de> <20161017135957.20297-3-ralf@ramses-pyramidenbau.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017135957.20297-3-ralf@ramses-pyramidenbau.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Ralf,

> On Oct 17, 2016, at 16:59 , Ralf Ramsauer =
<ralf@ramses-pyramidenbau.de> wrote:
>=20
> Instantiated I2C device nodes are marked with OF_POPULATE. This was
> introduced in 4f001fd. On unloading, loaded device nodes will of =
course
> be unmarked. The problem are nodes that fail during initialisation: If =
a
> node fails, it won't be unloaded and hence not be unmarked.
>=20
> If a I2C driver module is unloaded and reloaded, it will skip nodes =
that
> failed before.
>=20
> Skip device nodes that are already populated and mark them only in =
case
> of success.
>=20
> Note that the same issue exists for SPI.
>=20
> Fixes: 4f001fd ("i2c: Mark instantiated device nodes with =
OF_POPULATE")
> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
> ---
> drivers/i2c/i2c-core.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 5ab6721..1704fc8 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1681,6 +1681,7 @@ static struct i2c_client =
*of_i2c_register_device(struct i2c_adapter *adap,
> static void of_i2c_register_devices(struct i2c_adapter *adap)
> {
> 	struct device_node *bus, *node;
> +	struct i2c_client *client;
>=20
> 	/* Only register child devices if the adapter has a node pointer =
set */
> 	if (!adap->dev.of_node)
> @@ -1695,7 +1696,14 @@ static void of_i2c_register_devices(struct =
i2c_adapter *adap)
> 	for_each_available_child_of_node(bus, node) {
> 		if (of_node_test_and_set_flag(node, OF_POPULATED))
> 			continue;
> -		of_i2c_register_device(adap, node);
> +
> +		client =3D of_i2c_register_device(adap, node);
> +		if (IS_ERR(client)) {
> +			dev_warn(&adap->dev,
> +				 "Failed to create I2C device for %s\n",
> +				 node->full_name);
> +			of_node_clear_flag(node, OF_POPULATED);
> +		}
> 	}
>=20
> 	of_node_put(bus);
> @@ -2299,6 +2307,7 @@ static int of_i2c_notify(struct notifier_block =
*nb, unsigned long action,
> 		if (IS_ERR(client)) {
> 			dev_err(&adap->dev, "failed to create client for =
'%s'\n",
> 				 rd->dn->full_name);
> +			of_node_clear_flag(rd->dn, OF_POPULATED);
> 			return notifier_from_errno(PTR_ERR(client));
> 		}
> 		break;
> --=20
> 2.10.1
>=20

Thanks for this

Acked-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
