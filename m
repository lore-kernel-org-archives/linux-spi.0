From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Applied "spi: dw: explicitly free IRQ handler in
 dw_spi_remove_host()" to the spi tree
Date: Fri, 23 Oct 2015 10:40:58 +0300
Message-ID: <1445586058.22669.55.camel@linux.intel.com>
References: <E1ZpP0f-0000MP-5w@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <E1ZpP0f-0000MP-5w@finisterre>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2015-10-23 at 08:11 +0900, Mark Brown wrote:
> The patch
>=20
> =C2=A0=C2=A0=C2=A0spi: dw: explicitly free IRQ handler in dw_spi_remo=
ve_host()

This one seems incomplete.

Yes, we already have a fix=C2=A002f20387e1bc in your tree.

This makes free_irq() call duplicate. Please, remove it from your tree
or do the revert.


>=20
> has been applied to the spi tree at
>=20
> =C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/broon=
ie/spi.git=20
>=20
> All being well this means that it will be integrated into the linux-
> next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.=C2=
=A0=C2=A0
>=20
> You may get further e-mails resulting from automated or manual
> testing
> and review of the tree, please engage with people reporting problems
> and
> send followup patches addressing any issues that are reported if
> needed.
>=20
> If any updates are required or you are submitting further changes
> they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when
> replying
> to this mail.
>=20
> Thanks,
> Mark
>=20
> From 9f89566dac9ad776ad4d919922e99d799731e513 Mon Sep 17 00:00:00
> 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Tue, 20 Oct 2015 11:39:36 +0300
> Subject: [PATCH] spi: dw: explicitly free IRQ handler in
> dw_spi_remove_host()
>=20
> The following warning occurs when DW SPI is compiled as a module and
> it's a PCI
> device. On the removal stage pcibios_free_irq() is called earlier
> than
> free_irq() due to the latter is called at managed resources free
> strage.
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1003 at
> /home/andy/prj/linux/fs/proc/generic.c:575
> remove_proc_entry+0x118/0x150()
> remove_proc_entry: removing non-empty directory 'irq/38', leaking at
> least 'dw_spi1'
> Modules linked in: spi_dw_midpci(-) spi_dw [last unloaded:
> dw_dmac_core]
> CPU: 1 PID: 1003 Comm: modprobe Not tainted 4.3.0-rc5-next-20151013+
> #32
> =C2=A000000000 00000000 f5535d70 c12dc220 f5535db0 f5535da0 c104e912
> c198a6bc
> =C2=A0f5535dcc 000003eb c198a638 0000023f c11b4098 c11b4098 f54f1ec8
> f54f1ea0
> =C2=A0f642ba20 f5535db8 c104e96e 00000009 f5535db0 c198a6bc f5535dcc
> f5535df0
> Call Trace:
> =C2=A0[<c12dc220>] dump_stack+0x41/0x61
> =C2=A0[<c104e912>] warn_slowpath_common+0x82/0xb0
> =C2=A0[<c11b4098>] ? remove_proc_entry+0x118/0x150
> =C2=A0[<c11b4098>] ? remove_proc_entry+0x118/0x150
> =C2=A0[<c104e96e>] warn_slowpath_fmt+0x2e/0x30
> =C2=A0[<c11b4098>] remove_proc_entry+0x118/0x150
> =C2=A0[<c109b96a>] unregister_irq_proc+0xaa/0xc0
> =C2=A0[<c109575e>] free_desc+0x1e/0x60
> =C2=A0[<c10957d2>] irq_free_descs+0x32/0x70
> =C2=A0[<c109b1a0>] irq_domain_free_irqs+0x120/0x150
> =C2=A0[<c1039e8c>] mp_unmap_irq+0x5c/0x60
> =C2=A0[<c16277b0>] intel_mid_pci_irq_disable+0x20/0x40
> =C2=A0[<c1627c7f>] pcibios_free_irq+0xf/0x20
> =C2=A0[<c13189f2>] pci_device_remove+0x52/0xb0
> =C2=A0[<c13f6367>] __device_release_driver+0x77/0x100
> =C2=A0[<c13f6da7>] driver_detach+0x87/0x90
> =C2=A0[<c13f5eaa>] bus_remove_driver+0x4a/0xc0
> =C2=A0[<c128bf0d>] ? selinux_capable+0xd/0x10
> =C2=A0[<c13f7483>] driver_unregister+0x23/0x60
> =C2=A0[<c10bad8a>] ? find_module_all+0x5a/0x80
> =C2=A0[<c1317413>] pci_unregister_driver+0x13/0x60
> =C2=A0[<f80ac654>] dw_spi_driver_exit+0xd/0xf [spi_dw_midpci]
> =C2=A0[<c10bce9a>] SyS_delete_module+0x17a/0x210
>=20
> Explicitly call free_irq() at removal stage of the DW SPI driver.
>=20
> Fixes: 04f421e7b0b1 (spi: dw: use managed resources)
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> =C2=A0drivers/spi/spi-dw.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index cc2e980..ad66bc5 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -542,6 +542,8 @@ void dw_spi_remove_host(struct dw_spi *dws)
> =C2=A0{
> =C2=A0	dw_spi_debugfs_remove(dws);
> =C2=A0
> +	free_irq(dws->irq, dws->master);
> +
> =C2=A0	if (dws->dma_ops && dws->dma_ops->dma_exit)
> =C2=A0		dws->dma_ops->dma_exit(dws);
> =C2=A0

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
