Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B07C88CB2
	for <linux-spi@archiver.kernel.org>; Thu, 24 Aug 2023 07:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbjHXHnF (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 24 Aug 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjHXHms (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Aug 2023 03:42:48 -0400
Received: from mail.loanfly.pl (mail.loanfly.pl [141.94.250.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6DD1700
        for <linux-spi@vger.kernel.org>; Thu, 24 Aug 2023 00:42:30 -0700 (PDT)
Received: by mail.loanfly.pl (Postfix, from userid 1002)
        id 01BBCA4B52; Thu, 24 Aug 2023 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=loanfly.pl; s=mail;
        t=1692862940; bh=Y0HnXqH+26AP5Uq6M8BQXaj1HIAPQY/WndV9tkpAHHU=;
        h=Date:From:To:Subject:From;
        b=QKT1udytxQP5Ywo5vHrsnjWD4ftg9jPnHg637xgZEpyAwWeYfYsefDHm0zqaxH6FK
         1VMAknvtJnrr9mgPDj3ggsGEV0uuX7fhl0jEufIlx9kOPR9ckcu7tZLeBaCPC/YWEF
         Rm0UmtaP6lt8HewE8JeL4kFMJiaiJgAFcdYMXUAnIWVn/SUm0cStZBtgyJCn+9Kq+Z
         Gx5DoJOHPw4bdu0/N2uLdNvw0a7huVGBOEhs/AmjxLKb8Ae03efbh2/TejPolrRVnV
         GYKIn+PgGSdKzgGWDwKU0XskZvinxaMC0D/iFBlQ7jxj5XsUiL4W4olxTjtKlc7Wnm
         CBkK4e9+xNkkw==
Received: by mail.loanfly.pl for <linux-spi@vger.kernel.org>; Thu, 24 Aug 2023 07:40:57 GMT
Message-ID: <20230824064500-0.1.c3.1d6og.0.uhu7tbzf3e@loanfly.pl>
Date:   Thu, 24 Aug 2023 07:40:57 GMT
From:   "Damian Cichocki" <damian.cichocki@loanfly.pl>
To:     <linux-spi@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.loanfly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Damian Cichocki
